#!/bin/bash
# !!! WARNING! Please replace this lines by your devops pgp public key and email !!!
TRUSTED_ADMIN_KEY="denys_pubkey.asc"
TRUSTED_ADMIN_EMAIL="nuclearcat@nuclearcat.com"
MEDIAWIKI_URI="https://releases.wikimedia.org/mediawiki/1.31/mediawiki-1.31.5.tar.gz"

# Quick note (mostly for myself) how to delete MariaDB db and start from 0 for testing
# yum remove mariadb-server; rm -rf mediawiki-1.31.5.tar.gz ; rm -f mariadb-info.gpg ; rm -rf /var/lib/mysql/;rm -rf /var/www/html/wiki

function isinstalled {
  if yum list installed "$@" >/dev/null 2>&1; then
    true
  else
    false
  fi
}

if isinstalled centos-release-scl.noarch; then 
    echo Software collection already installed
else
    yum -y install centos-release-scl.noarch
fi

gpg --import ${TRUSTED_ADMIN_KEY}
if [ -f "mariadb-info.gpg" ]; then
    echo "You have old gpg file, at least MariaDB mariadb-info.gpg, to avoid overwriting - exiting. Please backup old files first"
    exit
fi

if isinstalled firewalld; then 
    echo "FirewallD is already installed";
else
    yum -y install firewalld
    systemctl start firewalld
    systemctl enable firewalld
    systemctl status firewalld
fi


ROOTPASS=`tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1`
if isinstalled mariadb-server; then 
    echo "MariaDB is already installed, halting as we dont know root password";
else
    echo "Installing MariaDB";
    yum -y install mariadb-server
    echo "MariaDB root password ${ROOTPASS}" | gpg --encrypt -o mariadb-info.gpg -r ${TRUSTED_ADMIN_EMAIL}
    systemctl start mariadb
    systemctl enable mariadb

    echo Setting new password
    mysqladmin password "${ROOTPASS}"
    if [ $? -ne 0 ]; then
	echo "mysqladmin failed, password is already set? terminating..."
	exit
    fi

    # TODO: Check return code
    echo "DELETE FROM mysql.user WHERE User='';" | mysql -p${ROOTPASS}
    echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" | mysql -p${ROOTPASS}
    echo "DROP DATABASE test;" | mysql -p${ROOTPASS}
    echo "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';" | mysql -p${ROOTPASS}
    echo "FLUSH PRIVILEGES;"| mysql -p${ROOTPASS}
fi


echo "Installing Apache and relevant rules"
if isinstalled httpd; then echo "apache(httpd) is already installed"; else 
    echo "Installing Apache";
    yum -y install httpd
    firewall-cmd --permanent --add-service=http --add-service=https
    firewall-cmd --reload
    systemctl start httpd
    systemctl enable httpd
fi

echo "Installing PHP"
if isinstalled rh-php72; then echo "php is already installed"; else 
    yum -y install rh-php72 rh-php72-php rh-php71-php-cli rh-php72-php-fpm
    systemctl enable rh-php72-php-fpm.service 
    systemctl start rh-php72-php-fpm.service
    systemctl status rh-php72-php-fpm.service
    scl enable rh-php72 bash
fi

echo "Installing PHP extensions"
if isinstalled rh-php72-php-mysqlnd; then echo "php-mysqlnd is already installed"; else 
    yum -y install rh-php72-php-mysqlnd rh-php72-php-mbstring
    systemctl restart rh-php72-php-fpm.service
fi

echo "# PHP scripts setup 
ProxyPassMatch ^/(.*.php)$ fcgi://127.0.0.1:9000/var/www/html

Alias / /var/www/html/

DirectoryIndex index.php
" > /etc/httpd/conf.d/fpm.conf
systemctl restart httpd



echo Cloudflare setup
yum -f install httpd-devel gcc
curl https://raw.githubusercontent.com/cloudflare/mod_cloudflare/master/mod_cloudflare.c --output mod_cloudflare.c
apxs -a -i -c mod_cloudflare.c 
systemctl restart httpd
if [ ! -f /etc/pki/tls/certs/cloudflare.crt ]; then
    echo "Go to Cloudflare panel, SSL/TLS, Origin Server, Create Certificate, then generate with defaults"
    echo "Now paste here Origin Certificate and then press Ctrl+D at the end"
    cat > /etc/pki/tls/certs/cloudflare.crt
    echo "Now paste here Origin Private key and then press Ctrl+D at the end"
    cat > /etc/pki/tls/private/cloudflare.key
    sed -i 's/localhost.crt/cloudflare.crt/g' /etc/httpd/conf.d/ssl.conf
    sed -i 's/localhost.key/cloudflare.key/g' /etc/httpd/conf.d/ssl.conf
    systemctl restart httpd
fi

# TODO: Make proper redirect
echo '<?php header("Location: /wiki/"); ?>' >/var/www/html/index.php

read -p "Do you want to install fresh mediawiki or backup? (fresh / backup) >" answerm
if [ "$answerm" = "fresh" ]; then
    echo "Installing mediawiki"
    WIKI_FILENAME="${MEDIAWIKI_URI##*/}"
    echo ${WIKI_FILENAME}
    if [ -f "${WIKI_FILENAME}" ]; then
	echo "Mediawiki file already present"
    else
	echo "Downloading mediawiki..."
	# TODO: Check return code
	curl ${MEDIAWIKI_URI} --output ${WIKI_FILENAME}
    fi

    WIKIDBPASS=`tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1`
    WIKIADMINPASS=`tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1`
    echo "Mediawiki admin password ${WIKIADMINPASS}" | gpg --encrypt -o wiki-info.gpg -r ${TRUSTED_ADMIN_EMAIL}
    mkdir /var/www/html/wiki
    tar -xvf ${WIKI_FILENAME} --strip 1 -C /var/www/html/wiki
    php /var/www/html/wiki/maintenance/install.php --installdbuser=root --installdbpass=${ROOTPASS} --dbuser=lbdocs --dbpass=${WIKIDBPASS} --confpath=/var/www/html/wiki --dbname=lbwiki --pass=${WIKIADMINPASS} "LBDocs" "Adminlb"
fi


#!/bin/bash
# !!! WARNING! Please replace following data by your devops pgp public key and email !!!
TRUSTED_ADMIN_EMAIL="nuclearcat@nuclearcat.com"
MEDIAWIKI_URI="https://releases.wikimedia.org/mediawiki/1.31/mediawiki-1.31.5.tar.gz"
gpg --import <<EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
neTtOo69uMsr9m4QNMtar6AFL2IV4b38
=tGg9
-----END PGP PUBLIC KEY BLOCK-----
EOF

# END OF USER DEFINED/CHANGEABLE DATA


# Quick note (mostly for myself) how to delete MariaDB db and start from 0 for testing
# yum remove -y mariadb-server; rm -rf mediawiki-1.31.5.tar.gz ; rm -f mariadb-info.gpg ; rm -rf /var/lib/mysql/;rm -rf /var/www/html/wiki; yum -y remove git; rm -rf BACKUP

function isinstalled {
  if yum list installed "$@" >/dev/null 2>&1; then
    true
  else
    false
  fi
}

if [ "$BASH_VERSION" = '' ]; then
    echo "You need to run this script under bash, e.g. bash $0"
fi

exec > >(tee -i install_log.txt)
exec 2>&1


if isinstalled centos-release-scl.noarch; then 
    echo Software collection already installed
else
    yum -y install centos-release-scl.noarch
fi

#gpg --import ${TRUSTED_ADMIN_KEY}
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
BACKUPPASS=`tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1`
if isinstalled mariadb-server; then 
    echo "MariaDB is already installed, halting as we dont know root password";
else
    echo "Installing MariaDB";
    yum -y install mariadb-server
    echo "MariaDB root password ${ROOTPASS}" | gpg --trust-model always --encrypt -o mariadb-rootinfo.gpg -r ${TRUSTED_ADMIN_EMAIL}
    echo "MariaDB backup password ${BACKUPPASS}" | gpg --trust-model always --encrypt -o mariadb-backupinfo.gpg -r ${TRUSTED_ADMIN_EMAIL}
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
    echo "CREATE USER 'backup'@'localhost' IDENTIFIED BY '${BACKUPPASS}'"| mysql -p${ROOTPASS}
    echo "GRANT SELECT, SHOW VIEW, RELOAD, REPLICATION CLIENT, EVENT, TRIGGER, LOCK TABLES ON *.* TO 'backup'@'localhost'"| mysql -p${ROOTPASS}
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
    #scl enable rh-php72 - << \EOF
    echo "source scl_source enable rh-php72" >>~/.bash_profile
fi
# Just in case, better here
source scl_source enable rh-php72

echo "Installing PHP extensions"
if isinstalled rh-php72-php-mysqlnd; then echo "php-mysqlnd is already installed"; else 
    yum -y install rh-php72-php-mysqlnd rh-php72-php-mbstring
    systemctl restart rh-php72-php-fpm.service
fi

echo "Installing FPM config"

echo "# PHP scripts setup 
ProxyPassMatch ^/(.*.php)$ fcgi://127.0.0.1:9000/var/www/html

Alias / /var/www/html/

DirectoryIndex index.php
" > /etc/httpd/conf.d/fpm.conf
systemctl restart httpd

echo Cloudflare setup
yum -y install httpd-devel gcc mod_ssl
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

if [ -f "backup.tgz" ]; then
    echo "WARNING! Backup found, typing backup strongly recommended!"
fi

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
    echo "Mediawiki Adminlb password ${WIKIADMINPASS}" | gpg --trust-model always --encrypt -o wiki-info.gpg -r ${TRUSTED_ADMIN_EMAIL}
    mkdir /var/www/html/wiki
    tar -xvf ${WIKI_FILENAME} --strip 1 -C /var/www/html/wiki
    php /var/www/html/wiki/maintenance/install.php --installdbuser=root --installdbpass=${ROOTPASS} --dbuser=lbdocs --dbpass=${WIKIDBPASS} --confpath=/var/www/html/wiki --dbname=lbwiki --pass=${WIKIADMINPASS} "LBDocs" "Adminlb"
    echo "Installing and initializing git for backups..."
    if [ ! -d BACKUP ]; then
        yum -y install git
        mkdir BACKUP
        cd BACKUP
        git init .
        git config --global user.name "LBDocs git user at `hostname`"
        git config --global user.email ${TRUSTED_ADMIN_EMAIL}
        rsync -av /var/www/html .
        cp ../mariadb-rootinfo.gpg .
        cp ../mariadb-backupinfo.gpg .
        cp ../wiki-info.gpg .
        mysqldump -p${ROOTPASS} --all-databases >db-dump.sql
	# TODO backup tls keys
        git add *
        git commit -a -m "Initial commit"
        cd ..
        tar -cz BACKUP | gpg --trust-model always --encrypt -o backup.tgz.gpg -r ${TRUSTED_ADMIN_EMAIL}
    fi
fi

if [ "$answerm" = "backup" ]; then
    echo Restoring backup
    tar zxf backup.tgz
    cd BACKUP
    rsync -av html/ /var/www/html/
    mysql -p${ROOTPASS} <db-dump.sql
    echo "FLUSH PRIVILEGES;"| mysql -p${ROOTPASS}
fi

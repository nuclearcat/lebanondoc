#!/bin/bash
# !!! WARNING! Please replace this lines by your devops pgp public key and email !!!
TRUSTED_ADMIN_KEY="denys_pubkey.asc"
TRUSTED_ADMIN_EMAIL="nuclearcat@nuclearcat.com"

# Quick note (mostly for myself) how to delete MariaDB db and start from 0
# yum remove mariadb-server
# rm -rf /var/lib/mysql

function isinstalled {
  if yum list installed "$@" >/dev/null 2>&1; then
    true
  else
    false
  fi
}

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


export ROOTPASS=`tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1`
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
if isinstalled php; then echo "php is already installed"; else 
    yum -y install php
fi

echo "Installing PHP-MySQLND"
if isinstalled php-mysqlnd; then echo "php-mysqlnd is already installed"; else 
    yum -y install php-mysqlnd
fi


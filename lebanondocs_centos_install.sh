#!/bin/bash
TRUSTED_ADMIN_KEY="denys_pubkey.asc"
TRUSTED_ADMIN_EMAIL="nuclearcat@nuclearcat.com"

function isinstalled {
  if yum list installed "$@" >/dev/null 2>&1; then
    true
  else
    false
  fi
}

gpg --import ${TRUSTED_ADMIN_KEY}

if isinstalled mariadb-server; then echo "MariaDB is already installed"; else 
    echo "Installing MariaDB";
    yum -y install mariadb-server
fi
if [ -f "mariadb-info.gpg" ]; then
    echo "You have old gpg file, at least MariaDB mariadb-info.gpg, to avoid overwriting - exiting. Please backup old files first"
    exit
fi

export ROOTPASS=`tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1`
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

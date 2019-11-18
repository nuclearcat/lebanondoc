#!/bin/sh
chown -R apache:apache /var/www/html/wiki/images/
sed -i 's/post_max_size = 8M/post_max_size = 100M/' /etc/opt/rh/rh-php72/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/' /etc/opt/rh/rh-php72/php.ini

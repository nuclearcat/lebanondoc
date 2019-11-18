#!/bin/sh
chown -R apache:apache /var/www/html/wiki/images/
chmod -R 775 /var/www/html/wiki/images/
sed -i 's/post_max_size = 8M/post_max_size = 100M/' /etc/opt/rh/rh-php72/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/' /etc/opt/rh/rh-php72/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 100M/' /etc/opt/rh/rh-php72/php-fpm.conf
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/' /etc/opt/rh/rh-php72/php-fpm.conf
sed -i -e "s/\$wgEnableUploads = false;/\$wgEnableUploads = true;/" /var/www/html/wiki/LocalSettings.php
chcon -R -t httpd_user_content_t /var/www/html/wiki
if [ ! -f /etc/httpd/conf/httpd.conf.bak ]; then
    cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
fi
sed -r '\%<Directory "/var/www/html">%,\%</Directory>% s%(AllowOverride)\s+None%\1 All%i' /etc/httpd/conf/httpd.conf >/etc/httpd/conf/httpd.conf.new
mv /etc/httpd/conf/httpd.conf.new /etc/httpd/conf/httpd.conf
semanage permissive -a httpd_t

systemctl restart httpd
systemctl restart rh-php72-php-fpm.service

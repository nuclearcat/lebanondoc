# lebanondoc
Lebanon wiki/files collaboration platform

Using Letsencrypt instead of cloudflare

yum install epel-release
yum install certbot python2-certbot-apache
certbot run --webroot -w /var/www/html -d corruptionrevolution.org --installer apache
systemctl restart httpd

service mysql start

# configuring nginx
mv ./tmp/site_nginx.conf /etc/nginx/sites-available/site
ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/site
rm -rf /etc/nginx/sites-enabled/default

#correct rights for nginx to work
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# SSL
mkdir /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/site.key -out /etc/nginx/ssl/site.pem -subj "/C=RU/ST=Tatar/L=Kazan/O=MyComp/CN=site.com"

# MySQL
mysql --user='root' --execute="CREATE DATABASE wp;"
mysql --user='root' --execute="CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'wp_user'"
mysql --user='root' --execute="GRANT ALL ON wp.* TO 'wp_user'@'localhost' IDENTIFIED BY 'wp_user'"
mysql --user='root' --execute="FLUSH PRIVILEGES"

# Site Folder
mkdir -p /var/www/site.com

# WordPress
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xf latest.tar.gz
mv /tmp/wordpress /var/www/site.com/
mv /tmp/wp-config.php /var/www/site.com/wordpress/

# PhpMyAdmin
cd /tmp
mkdir /var/www/site.com/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
tar -xf phpMyAdmin-5.0.4-all-languages.tar.gz 
mv /tmp/phpMyAdmin-5.0.4-all-languages/* /var/www/site.com/phpmyadmin
mv /tmp/phpmyadmin.inc.php /var/www/site.com/phpmyadmin/config.inc.php

service php7.3-fpm start
nginx -g "daemon off;" 

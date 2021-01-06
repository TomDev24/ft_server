service mysql start

# configuring nginx
mv ./tmp/site_nginx.conf /etc/nginx/sites-available/site
ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/site
rm -rf /etc/nginx/sites-enabled/default

# SSL
mkdir /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/site.key -out /etc/nginx/ssl/site.pem "/C=RU/ST=Tatar/L=Kazan/O=MyComp/CN=site.com"

# MySQL
mysql --user='root' --execute="CREATE DATABASE wp;"
mysql --user='root' --execute="CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'wp_user'"
mysql --user='root' --execute="GRANT ALL ON wp.* TO 'wp_user'@'localhost' IDENTIFIED BY 'wp_user'"
mysql --user='root' --execute="FLUSH PRIVILEGES"

# WordPress
mkdir -p /var/www/html/site.com
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar xf latest.tar.gz
mv /tmp/wordpress/* /var/www/html/site.com/
cd ..



nginx -g "daemon off;" 

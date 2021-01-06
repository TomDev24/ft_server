service mysql start

# configuring nginx
mv ./tmp/site_nginx.conf /etc/nginx/sites-available/site
ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/site
rm -rf /etc/nginx/sites-enabled/default

# SSL
mkdir /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/site.key -out /etc/nginx/ssl/site.pem "/C=RU/ST=Tatar/L=Kazan/O=MyComp/CN=site.com"

# MySQL


nginx -g "daemon off;" 

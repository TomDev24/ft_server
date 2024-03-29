FROM debian:buster

RUN apt-get update && apt-get install -y vim \
	&& apt-get install -y nginx \
	&& apt-get install -y php7.3-cli php7.3-fpm \
	php7.3-mysql php7.3-json php7.3-opcache \
	php7.3-mbstring php7.3-xml php7.3-gd php7.3-curl \
	&& apt-get install -y mariadb-server \
	&& apt-get install -y wget 

COPY ./srcs/start_container.sh .
COPY ./srcs/site_nginx.conf ./tmp
COPY ./srcs/wp-config.php ./tmp
COPY ./srcs/phpmyadmin.inc.php ./tmp
COPY ./srcs/index.html /var/www/site.com/

EXPOSE 80
EXPOSE 443

CMD bash start_container.sh

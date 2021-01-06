FROM debian:buster

RUN apt-get update && apt-get install -y vim \
	&& apt-get install -y nginx \
	&& apt-get install -y php7.3-cli php7.3-fpm \
	php7.3-mysql php7.3-json php7.3-opcache \
	php7.3-mbstring php7.3-xml php7.3-gd php7.3-curl \
	&& apt-get install -y mariadb-server

COPY ./srcs/start_container.sh ./tmp
COPY ./srcs/site_nginx.conf ./tmp
COPY ./srcs/index.html /var/www/html/
EXPOSE 80

CMD bash ./tmp/start_container.sh

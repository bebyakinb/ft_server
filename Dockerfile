FROM debian:buster
COPY ./srcs ./tmp

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install nginx wget mariadb-server \
	php-fpm php-mysql php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip 

RUN wget https://wordpress.org/latest.tar.gz \
	&& tar -xzvf latest.tar.gz \
	&& rm -fr latest.tar.gz

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz \
	&& tar -xzvf phpMyAdmin-5.0.2-english.tar.gz \
	&& rm -fr phpMyAdmin-5.0.2-english.tar.gz

CMD bash ./tmp/start_server.sh
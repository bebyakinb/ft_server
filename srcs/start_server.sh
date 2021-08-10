#!/bin/bash
# Update package list

chown -R www-data /var/www/*
chmod -R 755 /var/www/*
chmod -R 755 /tmp/*

mkdir /var/www/site
#touch /var/www/site/index.php
#echo "<?php echo \"Hello Habrahabr!\";" >> /var/www/site/index.php

#Config for MySQL
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

#wp
mv /wordpress /var/www/site/
mv /tmp/wp-config.php /var/www/site/wordpress

#phpmyadmin
mv /phpMyAdmin-5.0.2-english /var/www/site/phpmyadmin
mv /tmp/config.inc.php /var/www/site/phpmyadmin/config.inc.php

#ngingx
cp /tmp/nginx.conf /etc/nginx/sites-available/site
ln -s /etc/nginx/sites-available/site ./etc/nginx/sites-enabled/site
rm -rf /etc/nginx/sites-enabled/default

#ssl
mkdir ./etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out \
		/etc/nginx/ssl/site.pem -keyout /etc/nginx/ssl/site.key -subj \
		"/C=RU/ST=Moscow/L=Moscow/O=21 School/OU=enoelia/CN=site"


#Start all
service php7.3-fpm start
service nginx start

sleep infinity

#docker build -t ft_server .
#docker run -p 80:80 -p 443:443 --name ft_server ft_server
#docker exec ft_server sh -c tmp/autoindex_off.sh
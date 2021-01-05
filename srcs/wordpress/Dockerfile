FROM	alpine

RUN apk upgrade --available && apk add openrc
RUN apk add nginx && mkdir /run/nginx/ &&\
	adduser -D -g 'www' www &&\
	mkdir /www && chown -R www:www /var/lib/nginx && chown -R www:www /www
ADD ./src/nginx.conf /etc/nginx/nginx.conf
# ADD ./src/index.html /www/index.html
RUN nginx -t && rc-update add nginx default

# RUN apk add mysql mysql-client
# RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

RUN apk add wget php7-common php7-fpm php7-opcache php7-session php7-mbstring php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
RUN rc-status && touch /run/openrc/softlevel

RUN cd /www && wget http://wordpress.org/latest.tar.gz &&\
	tar -xzvf latest.tar.gz && rm latest.tar.gz

RUN rc-update add php-fpm7 default && rc-service php-fpm7 start &> /dev/null

# ADD ./src/data_base.sh /usr/bin/
# ADD users_data.sql /users_data.sql
# RUN mysql -u root < users_data.sql


# RUN rc-service mariadb restart && ./usr/bin/data_base.sh
RUN cd /www/wordpress/ && rm -rf wp-config.php
ADD ./src/wp-config-sample.php /www/wordpress/wp-config.php


ADD ./src/script.sh /usr/bin/

EXPOSE	5050

ENTRYPOINT /usr/bin/script.sh

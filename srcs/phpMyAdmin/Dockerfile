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
# RUN /etc/init.d/mariadb start && rc-update add mariadb default
# RUN /usr/bin/mysqladmin -u root password 'password'

RUN apk add php7-common php7-fpm php7-opcache php7-session php7-mbstring php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
RUN rc-status && touch /run/openrc/softlevel
# ADD ./src/data_bs.sh /usr/bin/
# RUN rc-service mariadb restart && ./usr/bin/data_bs.sh

RUN cd /www/ &&\
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz &&\
tar zxvf phpMyAdmin-5.0.4-all-languages.tar.gz && mv phpMyAdmin-5.0.4-all-languages phpmyadmin &&\
rm -rf phpMyAdmin-5.0.4-all-languages.tar.gz
RUN rc-update add php-fpm7 default && rc-service php-fpm7 restart &> /dev/null
RUN cd www/phpmyadmin/ && mkdir tmp && chmod 777 tmp
RUN chown -R www:www /www/phpmyadmin
ADD ./src/config.sample.inc.php /www/phpmyadmin/config.inc.php 

# ADD ./src/tt.php /www/
ADD ./src/script.sh /usr/bin/

EXPOSE	5050

ENTRYPOINT /usr/bin/script.sh


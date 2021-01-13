FROM	alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk upgrade --available && apk add openrc supervisor telegraf
RUN mkdir /etc/telegraf
RUN apk add nginx && mkdir /run/nginx/ &&\
	adduser -D -g 'www' www &&\
	mkdir /www &&\
	chown -R www:www /var/lib/nginx
ADD ./src/nginx.conf /etc/nginx/nginx.conf

RUN apk add php7-common php7-fpm php7-opcache php7-session php7-mbstring php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
RUN rc-status && touch /run/openrc/softlevel

RUN cd /www/ &&\
	wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz &&\
	tar zxvf phpMyAdmin-5.0.4-all-languages.tar.gz && mv phpMyAdmin-5.0.4-all-languages phpmyadmin &&\
	rm -rf phpMyAdmin-5.0.4-all-languages.tar.gz
RUN cd www/phpmyadmin/ && mkdir tmp && chmod 777 tmp
RUN chown -R www:www /www/phpmyadmin
ADD ./src/config.inc.php /www/phpmyadmin/config.inc.php 

ADD ./src/supervisord.conf /etc/
ADD ./src/telegraf.conf /etc/telegraf/

EXPOSE	5000

CMD ["/usr/bin/supervisord"]
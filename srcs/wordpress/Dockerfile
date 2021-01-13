FROM	alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk upgrade --available && apk add openrc nginx supervisor telegraf
RUN mkdir /etc/telegraf && mkdir /run/nginx/
RUN adduser -D -g 'www' www &&\
	mkdir /www && chown -R www:www /www &&\
	chown -R www:www /var/lib/nginx

ADD ./src/nginx.conf /etc/nginx/nginx.conf
RUN nginx -t && rc-update add nginx default

RUN apk add wget php7-common php7-fpm php7-opcache php7-session php7-mbstring php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
RUN rc-status && touch /run/openrc/softlevel

RUN cd /www && wget http://wordpress.org/latest.tar.gz &&\
	tar -xzvf latest.tar.gz && rm latest.tar.gz
RUN rc-update add php-fpm7 default && rc-service php-fpm7 start &> /dev/null
RUN chown -R www:www /www/wordpress

ADD ./src/wp-config.php /www/wordpress/wp-config.php
ADD ./src/supervisord.conf /etc/
ADD ./src/telegraf.conf /etc/telegraf/

EXPOSE 5050

CMD ["/usr/bin/supervisord"]
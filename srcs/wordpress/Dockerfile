FROM	alpine

RUN apk upgrade --available && apk add openrc --no-cache
RUN apk add nginx && mkdir /run/nginx/ &&\
	adduser -D -g 'www' www &&\
	mkdir /www && chown -R www:www /var/lib/nginx && chown -R www:www /www &&\
	mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./index.html /www/index.html
RUN nginx -t
RUN apk add php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype
ADD ./php7.sh /etc/profile.d/php7.sh



#ADD ./script.sh /usr/bin/

#VOLUME [ “/sys/fs/cgroup” ]

EXPOSE	443 80

#ENTRYPOINT /usr/bin/script.sh


# install rc-service:
# apk add openrc --no-cache

#CMD ["nginx", "-g", "daemon off;"]

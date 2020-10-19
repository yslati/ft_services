# docker-machine env default
# eval $(docker-machine env default)

FROM	alpine

RUN apk upgrade --available

RUN apk add nginx && mkdir /run/nginx/ &&\
	adduser -D -g 'www' www &&\
	mkdir /www && chown -R www:www /var/lib/nginx && chown -R www:www /www &&\
	mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

ADD ./nginx.conf /etc/nginx/nginx.conf

ADD ./index.html /www/index.html

RUN nginx -t

ADD ./script.sh /usr/bin/

EXPOSE	443 80

ENTRYPOINT /usr/bin/script.sh
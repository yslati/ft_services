FROM alpine

RUN apk upgrade --available && apk add openrc

RUN apk add nginx && mkdir /run/nginx/ &&\
	adduser -D -g 'www' www &&\
	mkdir /www && chown -R www:www /var/lib/nginx && chown -R www:www /www &&\
	mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./index.html /www/index.html

RUN nginx -t

EXPOSE 5000
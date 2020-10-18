# docker-machine env default
# eval $(docker-machine env default)

FROM	alpine

RUN apk add busybox-static apk-tools-static &&\
	sed -i -e 's/v2\.7/v3.0/g' /etc/apk/repositories &&\
	apk.static update && apk.static upgrade --no-self-upgrade --available --simulate &&\
	apk.static upgrade --no-self-upgrade --available &&\
	apk update && apk add --upgrade apk-tools &&\
	apk upgrade --available

RUN apk add nginx && mkdir /run/nginx/ &&\
	adduser -D -g 'www' www &&\
	mkdir /www && chown -R www:www /var/lib/nginx && chown -R www:www /www &&\
	mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

ADD ./srcs/nginx/nginx.conf /etc/nginx/nginx.conf
ADD ./srcs/nginx/index.html /www/index.html

RUN nginx -t && nginx -g "daemon off ;"

EXPOSE	443 80
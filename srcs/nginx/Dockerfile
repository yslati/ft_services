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
RUN apk add openssl &&\
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/CN=localhost"
RUN nginx -t
RUN apk add openssh
RUN adduser -D user
RUN echo "user:password"|chpasswd
RUN ssh-keygen -A



ADD ./script.sh /usr/bin/

EXPOSE	443 80 22

ENTRYPOINT /usr/bin/script.sh
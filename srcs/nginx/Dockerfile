FROM	alpine:3.12.3

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk upgrade --available && apk add nginx openrc supervisor openssl openssh telegraf
RUN mkdir /etc/telegraf
RUN mkdir /run/nginx/ &&\
	adduser -D -g 'www' www &&\
	mkdir /www &&\
	chown -R www:www /var/lib/nginx

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/CN=localhost"
RUN rc-status && mkdir /run/openrc/softlevel
RUN adduser -D admin
RUN echo "admin:admin"|chpasswd
RUN ssh-keygen -A

ADD ./src/nginx.conf /etc/nginx/nginx.conf
ADD src/supervisord.conf /etc/
ADD ./src/telegraf.conf /etc/telegraf/
COPY ./src/index /www/index
RUN chown -R www:www /www/index

EXPOSE 80 443 22

CMD [ "/usr/bin/supervisord" ]
FROM	alpine

RUN apk upgrade --available && apk add openrc
RUN apk add nginx && mkdir /run/nginx/ &&\
	adduser -D -g 'www' www &&\
	mkdir /www && chown -R www:www /var/lib/nginx && chown -R www:www /www

ADD ./src/nginx.conf /etc/nginx/nginx.conf
RUN apk add openssl &&\
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/CN=localhost"
RUN nginx -t
RUN apk add openssh && rc-status && mkdir /run/openrc/softlevel && /etc/init.d/sshd start &>/dev/null
RUN adduser -D admin
RUN echo "admin:admin"|chpasswd
RUN ssh-keygen -A

ADD ./src/script.sh /usr/bin/


COPY ./src/index /www/index
RUN chown -R www:www /www/index
# RUN cd www/ && unzip Archive.zip


EXPOSE	443 80 22

ENTRYPOINT /usr/bin/script.sh
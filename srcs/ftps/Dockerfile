FROM alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add telegraf
RUN mkdir /etc/telegraf
RUN apk upgrade --available && apk add openrc vsftpd openssl supervisor
RUN adduser -D admin
RUN echo "admin:admin" | chpasswd
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem 

ADD ./src/vsftpd.conf /etc/vsftpd/vsftpd.conf
ADD src/supervisord.conf /etc/

EXPOSE 21

CMD ["usr/bin/supervisord"]
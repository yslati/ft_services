FROM alpine:3.12.3

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk upgrade --available && apk add vsftpd openssl supervisor telegraf
RUN mkdir /etc/telegraf
RUN mkdir -p /usr/share/ssl/certs && cd /usr/share/ssl/certs &&\
    openssl req -x509 -sha256 -nodes -days 365 -subj "/CN=FTP" -newkey rsa:2048 -keyout vsftpd.key -out vsftpd.pem
RUN adduser -D admin
RUN echo "admin:admin" | chpasswd

ADD ./src/vsftpd.conf /etc/vsftpd/vsftpd.conf
ADD src/supervisord.conf /etc/
ADD ./src/telegraf.conf /etc/telegraf/

EXPOSE 21 21000

CMD ["usr/bin/supervisord"]

FROM alpine

RUN apk upgrade --available && apk add openrc vsftpd openssl
RUN adduser -D admin
RUN echo "admin:admin" | chpasswd
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem 

ADD ./src/vsftpd.conf /etc/vsftpd/vsftpd.conf

ADD /src/run.sh /usr/bin/

EXPOSE 21

CMD /usr/bin/run.sh
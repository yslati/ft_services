FROM alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk upgrade --available && apk add openrc telegraf supervisor
RUN mkdir /etc/telegraf
RUN apk add mariadb mariadb-client
RUN openrc && touch /run/openrc/softlevel

ADD src/wordpress.sql /
ADD src/script.sh /usr/bin/
ADD ./src/telegraf.conf /etc/telegraf/
ADD src/supervisord.conf /etc/

ENTRYPOINT /usr/bin/script.sh
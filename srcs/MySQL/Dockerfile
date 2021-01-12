FROM alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add telegraf
RUN mkdir /etc/telegraf
RUN apk upgrade --available && apk add openrc
RUN apk add mariadb mariadb-client
RUN openrc && touch /run/openrc/softlevel

# RUN /etc/init.d/mariadb setup
# RUN rc-service mariadb start && rc-update add mariadb default
ADD src/wordpress.sql /
# RUN rc-service mariadb restart && mysql -u root < wordpress.sql


ADD src/script.sh /usr/bin/


ENTRYPOINT /usr/bin/script.sh

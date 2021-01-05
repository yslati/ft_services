FROM alpine

RUN apk upgrade --available && apk add openrc
RUN apk add mariadb mariadb-client
RUN openrc && touch /run/openrc/softlevel
# RUN /etc/init.d/mariadb setup
# RUN rc-service mariadb start && rc-update add mariadb default


ADD src/script.sh /usr/bin/


ENTRYPOINT /usr/bin/script.sh

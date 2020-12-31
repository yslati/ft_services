# FROM alpine

# RUN apk upgrade --available && apk add openrc &&\
#     apk add mysql mysql-client

# RUN openrc default
# RUN /etc/init.d/mariadb setup &&\
#     /etc/init.d/mariadb start


# EXPOSE 3306


# openrc default
FROM alpine

RUN apk upgrade --available && apk add openrc
RUN apk add mysql mysql-client
RUN rc-status && touch /run/openrc/softlevel
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql
RUN rc-service mariadb start

ADD src/script.sh /usr/bin/

ENTRYPOINT /usr/bin/script.sh


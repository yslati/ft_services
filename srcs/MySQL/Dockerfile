FROM alpine

RUN apk upgrade --available && apk add openrc
RUN apk add mysql mysql-client
RUN rc-status && touch /run/openrc/softlevel
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql
RUN rc-service mariadb start && rc-update add mariadb default

ADD ./src/wp_data_base.sh /usr/bin/
RUN rc-service mariadb restart && ./usr/bin/wp_data_base.sh

ADD ./src/my.cnf /etc/mysql/

ADD src/script.sh /usr/bin/


ENTRYPOINT /usr/bin/script.sh


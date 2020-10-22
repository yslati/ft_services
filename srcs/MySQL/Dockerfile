# FROM alpine

# RUN apk upgrade --available && apk add openrc &&\
#     apk add mysql mysql-client

# RUN openrc default
# RUN /etc/init.d/mariadb setup &&\
#     /etc/init.d/mariadb start


# EXPOSE 3306


# openrc default
FROM alpine

RUN apk upgrade --available && apk add openrc &&\
    apk add mariadb mariadb-client

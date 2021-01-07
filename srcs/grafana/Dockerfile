FROM alpine

RUN apk update && apk upgrade --available && apk add wget
RUN apk add libc6-compat telegraf

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.14.0-static_linux_amd64.tar.gz
RUN tar zxvf telegraf-1.17.0_linux_amd64.tar.gz \
    && rm -rf telegraf-1.17.0_linux_amd64.tar.gz

RUN chmod +x telegraf/*
RUN cp telegraf/telegraf /usr/bin/telegraf
RUN mkdir -p /etc/telegraf
RUN cp ./src/telegraf.conf /etc/telegraf/telegraf.conf
ADD ./src/entry-point.sh /usr/bin/entry-point.sh

ENTRYPOINT /usr/bin/entry-point.sh
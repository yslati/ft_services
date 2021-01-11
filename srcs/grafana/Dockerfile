FROM alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && apk add libc6-compat supervisor
RUN wget https://dl.grafana.com/oss/release/grafana-7.3.1.linux-amd64.tar.gz
RUN tar -zxvf grafana-7.3.1.linux-amd64.tar.gz
RUN mv grafana-7.3.1 grafana

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.14.0-static_linux_amd64.tar.gz
RUN tar zxvf telegraf-1.14.0-static_linux_amd64.tar.gz \
    && rm -rf telegraf-1.14.0-static_linux_amd64.tar.gz
RUN chmod +x telegraf/*
RUN cp telegraf/telegraf /usr/bin/telegraf
RUN mkdir -p /etc/telegraf

ADD src/telegraf.conf /etc/telegraf.conf
ADD src/run.sh /usr/bin/

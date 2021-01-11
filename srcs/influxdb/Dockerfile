FROM alpine

RUN apk add influxdb openrc 
RUN openrc &> /dev/null && touch /run/openrc/softlevel
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.14.0-static_linux_amd64.tar.gz
RUN tar zxvf telegraf-1.14.0-static_linux_amd64.tar.gz \
    && rm -rf telegraf-1.14.0-static_linux_amd64.tar.gz

RUN chmod +x telegraf/*
RUN cp telegraf/telegraf /usr/bin/telegraf
RUN mkdir -p /etc/telegraf
COPY src/telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 8086

#ENTRYPOINT /usr/bin/run.sh
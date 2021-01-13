FROM alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add influxdb openrc telegraf supervisor
RUN mkdir -p /etc/telegraf
RUN mkdir -p /etc/influxdb
RUN openrc &> /dev/null && touch /run/openrc/softlevel

COPY src/telegraf.conf /etc/telegraf/
COPY src/supervisord.conf /etc/
COPY src/influxdb.conf /etc/influxdb/

EXPOSE 8086

CMD ["/usr/bin/supervisord"]

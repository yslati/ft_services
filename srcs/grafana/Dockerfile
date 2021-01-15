FROM alpine:3.12.3

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update && apk add libc6-compat supervisor telegraf
RUN wget https://dl.grafana.com/oss/release/grafana-7.3.1.linux-amd64.tar.gz
RUN tar -zxvf grafana-7.3.1.linux-amd64.tar.gz
RUN mv grafana-7.3.1 grafana
RUN mkdir -p /etc/telegraf
RUN mkdir -p /etc/grafana

ADD src/supervisord.conf /etc/
ADD src/telegraf.conf /etc/telegraf/telegraf.conf
ADD src/grafana.db /grafana/data/


CMD ["/usr/bin/supervisord"]

#!/bin/bash

docker build -t phpmyadmin srcs/phpmyadmin
docker build -t mysql srcs/MySQL
docker build -t nginx srcs/nginx
docker build -t wordpress srcs/wordpress
docker build -t ftps srcs/ftps
docker build -t grafana srcs/grafana
docker build -t influxdb srcs/influxdb

kubectl apply -f phpmyadmin.yaml
kubectl apply -f mysql.yaml
kubectl apply -f wordpress.yaml
kubectl apply -f nginx.yaml
kubectl apply -f ftps.yaml
kubectl apply -f influxdb.yaml
kubectl apply -f grafana.yaml

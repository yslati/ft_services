#!/bin/bash

docker build -t nginx srcs/nginx
docker build -t mysql srcs/MySQL
docker build -t phpmyadmin srcs/phpmyadmin
docker build -t wordpress srcs/wordpress
docker build -t grafana srcs/grafana
docker build -t influxdb srcs/influxdb

kubectl apply -f phpmyadmin.yaml
kubectl apply -f mysql.yaml
kubectl apply -f wordpress.yaml
kubectl apply -f nginx.yaml
kubectl apply -f ftps.yaml

#!/bin/bash

docker build -t nginx srcs/nginx
docker build -t mysql srcs/MySQL
docker build -t phpmyadmin srcs/phpmyadmin
docker build -t wordpress srcs/wordpress
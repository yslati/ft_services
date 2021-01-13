#!/bin/bash

minikube delete
echo -e "\033[1;31m######## minikube Deleted ########\033[0m"

minikube start --vm-driver=virtualbox --memory=4g --disk-size=20g --cpus=4
echo -e "\033[33m######## minikube started ########\033[0m"

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f metallb.yaml

kubectl get svc


# docker build -t mysql srcs/MySQL
# docker build -t phpmyadmin srcs/phpmyadmin
# docker build -t nginx srcs/nginx
# docker build -t wordpress srcs/wordpress
# docker build -t ftps srcs/ftps

# kubectl apply -f phpmyadmin.yaml
# kubectl apply -f mysql.yaml
# kubectl apply -f wordpress.yaml
# kubectl apply -f nginx.yaml
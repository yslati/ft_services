#!/bin/bash

minikube delete
echo -e "\033[1;31m######## minikube Deleted ########\033[0m"

minikube start --vm-driver=virtualbox --memory=4g --disk-size=20g --cpus=4
echo -e "\033[33m######## minikube started ########\033[0m"

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f metallb.yaml

kubectl get svc
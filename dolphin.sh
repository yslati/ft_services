#!/bin/bash

arr=(phpmyadmin mysql wordpress nginx ftps influxdb grafana)

echo -e "\033[1;34m
    ____________  _____                 _               
   / ____/_  __/ / ___/___  ______   __(_)_______  _____
  / /_    / /    \__ \/ _ \/ ___/ | / / / ___/ _ \/ ___/
 / __/   / /    ___/ /  __/ /   | |/ / / /__/  __(__  ) 
/_/     /_/____/____/\___/_/    |___/_/\___/\___/____/  
         /_____/                                        
\033[0m"

if [[ $1 == "delete" ]]
then
	for i in "${arr[@]}"; do
		kubectl delete -f $i.yaml
	done
else
##### install brew #####
	if ! which brew &>/dev/null ; then
		echo -e "\n\033[33m-------> brew not found :o\033[0m\n"
		cd ~
		rm -rf .brew
		curl -L https://github.com/Homebrew/brew/archive/1.9.0.tar.gz > brew1.9.0.tar.gz
		echo -e "\n\033[33m-------> Installing brew ...\033[0m\n"
		tar -xvzf brew1.9.0.tar.gz	
		rm -rf brew1.9.0.tar.gz
		mv brew-1.9.0 .brew
		mv .brew ./goinfre
		ln -s ./goinfre/.brew
		if ls ~/.brew &>/dev/null ; then 
			echo -e "\n\033[32m-------> brew has been installed successfully \033[0m\n"
		else
			echo -e "\n\033[31m-------> brew has NOT been installed :(  \033[0m\n"
			exit 1
		fi
	else
		echo -e "\n\033[32m-------> brew already installed \033[0m\n"
	fi

##### install kubectl #####
	if ! which kubectl &>/dev/null ; then
		echo -e "\n\033[33m-------> kubectl not found :o\033[0m\n"
		cd ~
		brew install kubectl
		rm -rf .kube
		mkdir /goinfre/$USER/.kube
		ln -s ./goinfre/$USER/.kube
		if kubectl &>/dev/null ; then
			echo -e "\n\033[32m-------> kubectl has been installed successfully \033[0m\n"
		else
			echo -e "\n\033[31m-------> kubectl has NOT been installed :(  \033[0m\n"
			exit 1
		fi
	else
		echo -e "\n\033[32m-------> kubectl already installed \033[0m\n"
	fi

##### install minikube ##### 
	if ! which minikube &>/dev/null ; then
		echo -e "\n\033[33m-------> minikube not found :o\033[0m\n"
		cd ~
		brew install minikube
		rm -rf .minikube
		mkdir /goinfre/$USER/.minikube
		ln -s ./goinfre/$USER/.minikube
		if minikube &>/dev/null ; then
			echo -e "\n\033[32m-------> minikube has been installed successfully \033[0m\n"
		else
			echo -e "\n\033[31m-------> minikube has NOT been installed :(  \033[0m\n"
			exit 1
		fi
	else
		echo -e "\n\033[32m-------> minikube already installed \033[0m\n"
	fi
	
##### Delete Old minikube VM #####
	echo -e "\033[1;33m######## Delete Old minikube VM ########\033[0m"
	minikube delete
	echo -e "\033[1;32m######## minikube VM Deleted ########\033[0m\n"

##### Start New minikube VM #####
	echo -e "\033[1;33m######## Start New minikube VM ########\033[0m"
	minikube start --vm-driver=virtualbox --memory=4g --disk-size=20g --cpus=4
	echo -e "\033[1;32m######## minikube VM started ########\033[0m\n"

##### Setup LoadBalancer (metallb) #####
	echo -e "\033[1;33m######## Setup LoadBalancer ########\033[0m"
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/namespace.yaml
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
	kubectl apply -f metallb.yaml
	echo -e "\033[1;32m######## LoadBalancer Running ########\033[0m\n"

##### Point shell ro minikube's docker-daemon #####
	eval $(minikube docker-env)

##### Build Docker images #####
	echo -e "\033[1;33m######## Build Docker images ########\033[0m"
	for i in "${arr[@]}"; do
		docker build -t $i srcs/$i/
	done
	echo -e "\033[1;32m######## Docker images builded ########\033[0m\n"

##### Apply Deployment & Services #####
	echo -e "\033[1;33m######## apply Deployment & Services ########\033[0m"
	for i in "${arr[@]}"; do
		kubectl apply -f $i.yaml
	done
	# echo -e "\033[1;32m######## DONE ########\033[0m"

##### Minikube dashboard #####
	echo -e "\033[1;33m######## Start minikube dashboard ########\033[0m"
	sleep 30
	minikube dashboard
fi

#!/bin/bash

echo -e "\033[1;34m
    ____________  _____                 _               
   / ____/_  __/ / ___/___  ______   __(_)_______  _____
  / /_    / /    \__ \/ _ \/ ___/ | / / / ___/ _ \/ ___/
 / __/   / /    ___/ /  __/ /   | |/ / / /__/  __(__  ) 
/_/     /_/____/____/\___/_/    |___/_/\___/\___/____/  
         /_____/                                        
\033[0m\n"


arr=(phpmyadmin mysql wordpress nginx ftps influxdb grafana)
MINIKUBE_IP=`minikube ip`
SERVICE_IP=`kubectl get svc | grep nginx | awk '{print $4}'`
SSH_USERNAME="admin";	SSH_PASSWORD="admin"
FTPS_USERNAME="admin";	FTPS_PASSWORD="admin"
DB_USER="admin";		DB_PASSWORD="admin"

function show_info() {
    echo -e "\033[0;32m	✅ft_services deployment done (Hourra !)\033[0m"
    echo -e "\033[1;32m
    Minikube IP is : $MINIKUBE_IP
    =========================================================================
    WEB_Server:
        nginx:			https://$SERVICE_IP (or http)
        wordpress:		http://$SERVICE_IP:5050
        phpmyadmin:		http://$SERVICE_IP:5000
        grafana:		http://$SERVICE_IP:3000

    Protocols:
        SSH:			ssh admin@$SERVICE_IP -p 22
        FTPS:			use FILEZILLA
        
    DATA_BASES:			(username:password)
        ssh:			$SSH_USERNAME:$SSH_PASSWORD	(port 22)
        ftps:			$FTPS_USERNAME:$FTPS_PASSWORD	(port 21)
        database:		$DB_USER:$DB_PASSWORD	(sql / phpmyadmin)
        grafana:		admin:admin	(default)
        wordpress:              yassin:yassin	(admin)

    \033[0m"
}
function instruction() {
    echo -e "\033[0;32m	========= Instructions ===========================\033[0m"
	echo -e "\033[1;33m 
	delete	:	delete all deployment and Services.
	apply	:	apply all deploymrnt and Services.
	show	:	show services IP and logins info.
	\033[0m\n"
}

if [[ $1 == "delete" ]]; then
	for i in "${arr[@]}"; do
		kubectl delete -f srcs/$i.yaml
	done

elif [[ $1 == "apply" ]]; then
	for i in "${arr[@]}"; do
		kubectl apply -f srcs/$i.yaml
	done

elif [[ $1 == "show" ]]; then
	show_info

elif [[ $1 == "help" ]]; then
	instruction

else
##### install brew #####
	if ! which brew &>/dev/null ; then
		echo -e "\n\033[33m-------> brew not found :o\033[0m\n"
		cd ~
		rm -rf .brew
		curl -L https://github.com/Homebrew/brew/archive/1.9.0.tar.gz > brew1.9.0.tar.gz
		echo -e "\n\033[33m-------> Installing brew ...\033[0m\n"
		tar -xvzf brew1.9.0.tar.gz &>/dev/null
		rm -rf brew1.9.0.tar.gz
		rm -rf .brew && rm -rf ~/goinfre/.brew &>/dev/null
		mv brew-1.9.0 .brew
		mv .brew ./goinfre/.brew
		ln -s ./goinfre/.brew
		cd -
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
	if ! minikube start &>/dev/null ; then
		minikube delete &>/dev/null
		echo -e "\033[36mCheck minikube and Docker\033[0m\n"

	# if ! which kubectl &>/dev/null ; then
		echo -e "\n\033[33m-------> kubectl not found :o\033[0m\n"
		cd ~
		rm -rf .kube
		brew install kubectl
		rm -rf .kube
		mkdir /goinfre/.kube
		ln -s ./goinfre/.kube
		cd -
		if kubectl &>/dev/null ; then
			echo -e "\n\033[32m-------> kubectl has been installed successfully \033[0m\n"
		else
			echo -e "\n\033[31m-------> kubectl has NOT been installed :(  \033[0m\n"
			exit 1
		fi

##### install minikube ##### 
	# if ! which minikube &>/dev/null ; then
		echo -e "\n\033[33m-------> minikube not found :o\033[0m\n"
		cd ~
		rm -rf .minikube
		brew install minikube
		rm -rf .minikube
		mkdir /goinfre/.minikube
		ln -s ./goinfre/.minikube
		cd -
		if minikube &>/dev/null ; then
			echo -e "\n\033[32m-------> minikube has been installed successfully \033[0m\n"
		else
			echo -e "\n\033[31m-------> minikube has NOT been installed :(  \033[0m\n"
			exit 1
		fi

##### install Docker ##### 
	# if ! which docker &>/dev/null ; then
		echo -e "\n\033[33m-------> Docker not found :o\033[0m\n"
		cd ~
		rm -rf .docker
		brew install docker
		rm -rf .docker
		mkdir /goinfre/.docker
		ln -s ./goinfre/.docker
		cd -
		if docker &>/dev/null ; then
			echo -e "\n\033[32m-------> Docker has been installed successfully \033[0m\n"
		else
			echo -e "\n\033[31m-------> Docker has NOT been installed :(  \033[0m\n"
			exit 1
		fi
	else
		echo -e "\n\033[32m-------> kubectl already installed \033[0m\n"
		echo -e "\n\033[32m-------> minikube already installed \033[0m\n"
		echo -e "\n\033[32m-------> Docker already installed \033[0m\n"
	fi

##### Delete Old minikube VM #####
	echo -e "\033[1;33m######## Delete Old minikube VM ########\033[0m"
	minikube delete &>/dev/null
	minikube delete &>/dev/null
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
	kubectl apply -f srcs/metallb.yaml
	echo -e "\033[1;32m######## LoadBalancer Running ########\033[0m\n"

##### Point shell ro minikube's docker-daemon #####
	eval $(minikube docker-env)

##### Build Docker images #####
	echo -e "\033[1;33m######## Build Docker images ########\033[0m"
	for i in "${arr[@]}"; do
		docker build -t $i srcs/$i
	done
	echo -e "\033[1;32m######## Docker images builded ########\033[0m\n"

##### Apply Deployment & Services #####
	echo -e "\033[1;33m######## apply Deployment & Services ########\033[0m"
	for i in "${arr[@]}"; do
		kubectl apply -f srcs/$i.yaml
		sleep 2
	done
	# echo -e "\033[1;32m######## DONE ########\033[0m"

##### Minikube dashboard #####
	echo -e "\033[1;33m######## Start minikube dashboard ########\033[0m"
	sleep 20
	minikube dashboard
fi

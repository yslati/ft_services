#!/bin/bash
OUTPUT=$(docker-machine ls | awk '{print $1}' | grep default)
if [[ OUTPUT != 'default' ]]
then
	docker-machine create --driver virtualbox default
fi
	echo "machine alredy created"
docker-machine env default &&\
eval $(docker-machine env default)

#!/bin/bash

#docker-machine ls > /dev/null
OUTPUT=$(docker-machine ls | awk '{print $1}' | grep default)
if [[ $OUTPUT == 'default' ]]; then
    docker-machine rm default -y
fi

OUTPUT=$(docker-machine ls | awk '{print $1}' | grep default)
if [[ $OUTPUT != 'default' ]]; then # we will add more complex testing like docker-machine status
    echo "Start creating virtualBox ..."
    docker-machine create --driver virtualbox default > /dev/null
    echo "VirtualBox created "
    docker-machine env default
    eval $(docker-machine env default)
    echo "Done"
    eval $(docker-machine env default)
    docker-machine start
fi
#

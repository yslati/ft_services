#!/bin/bash

#docker-machine ls > /dev/null
OUTPUT=$(docker-machine ls | awk '{print $1}' | grep default)
if [[ $OUTPUT == 'default' ]]; then
    docker-machine rm default -y
fi

OUTPUT=$(docker-machine ls | awk '{print $1}' | grep default)
if [[ $OUTPUT != 'default' ]]; then # we will add more complex testing like docker-machine status
    echo -e "\033[0;31mStart creating virtualBox"
    docker-machine create --driver virtualbox default > /dev/null
    echo -e "\033[1;33mVirtualBox created"
    docker-machine env default
    eval $(docker-machine env default)
    echo -e "\033[0;32mDone"
    docker-machine start
fi
#

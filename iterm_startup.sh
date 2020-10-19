#!/bin/bash

typeset cmnd="docker-machine ls --filter name='default' --filter state='stopped' | grep default"
typeset ret_code

echo "running startup script ===> ${cmnd}"
eval $cmnd
ret_code=$?

# If not 0, means docker vm has already started
if [ $ret_code != 0 ]; then
    eval $(docker-machine env default)
# If 0, means defai;t docker vm not yet started
elif [ $ret_code == 0 ]; then
    docker-machine start default
fi

#!/bin/bash

echo -e "\033[1;34m
    ____________  _____                 _               
   / ____/_  __/ / ___/___  ______   __(_)_______  _____
  / /_    / /    \__ \/ _ \/ ___/ | / / / ___/ _ \/ ___/
 / __/   / /    ___/ /  __/ /   | |/ / / /__/  __(__  ) 
/_/     /_/____/____/\___/_/    |___/_/\___/\___/____/  
         /_____/                                        
\033[0m\n\n"

arr=(phpMyAdmin MySQL WordPress nginx FTPS InfluxDB Grafana)


for i in "${arr[@]}"; do
		docker build -t $i srcs/$i/
	done
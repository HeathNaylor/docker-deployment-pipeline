#!/usr/bin/env bash

# Stand up machines
docker-machine create --driver virtualbox myapp-qa-manager
docker-machine create --driver virtualbox myapp-qa-1
docker-machine create --driver virtualbox myapp-qa-2

docker-machine create --driver virtualbox myapp-prod-manager
docker-machine create --driver virtualbox myapp-prod-1
docker-machine create --driver virtualbox myapp-prod-2

# Setup swarms
docker-machine ssh myapp-qa-manager \
"docker swarm init --advertise-addr $(docker-machine ip myapp-qa-manager):2377"

docker-machine ssh myapp-prod-manager \
"docker swarm init --advertise-addr $(docker-machine ip myapp-prod-manager):2377"

QA_MANAGER_TOKEN=`docker-machine ssh myapp-qa-manager \
"docker swarm join-token worker" | grep token | awk '{ print $5 }'`

PROD_MANAGER_TOKEN=`docker-machine ssh myapp-prod-manager \
"docker swarm join-token worker" | grep token | awk '{ print $5 }'`

docker-machine ssh myapp-qa-1 \
"docker swarm join --token $QA_MANAGER_TOKEN $(docker-machine ip myapp-qa-manager):2377"

docker-machine ssh myapp-qa-2 \
"docker swarm join --token $QA_MANAGER_TOKEN $(docker-machine ip myapp-qa-manager):2377"

docker-machine ssh myapp-prod-1 \
"docker swarm join --token $PROD_MANAGER_TOKEN $(docker-machine ip myapp-prod-manager):2377"

docker-machine ssh myapp-prod-2 \
"docker swarm join --token $PROD_MANAGER_TOKEN $(docker-machine ip myapp-prod-manager):2377"

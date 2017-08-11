#!/bin/bash

cd "$(dirname "$0")"

docker-machine scp ../.env.prod myapp-prod-manager:/home/docker/.env

docker-machine scp ./docker-compose-deploy.yml \
myapp-prod-manager:/home/docker/docker-compose-deploy.yml

docker-machine ssh myapp-prod-manager \
"docker stack deploy -c docker-compose-deploy.yml myapp"

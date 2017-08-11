#!/bin/bash

cd "$(dirname "$0")"

docker-machine scp ../.env.qa myapp-qa-manager:/home/docker/.env

docker-machine scp ./docker-compose-deploy.yml \
myapp-qa-manager:/home/docker/docker-compose-deploy.yml

docker-machine ssh myapp-qa-manager \
"docker stack deploy -c docker-compose-deploy.yml myapp"

#!/bin/bash

cd "$(dirname "$0")"

docker-compose -f ./docker-compose-deploy-image-build.yml rm -f

if [[ "$(docker images -q image-untagged 2> /dev/null)" != "" ]]; then
  docker rmi image-untagged
fi

docker-compose -f ./docker-compose-deploy-image-build.yml build

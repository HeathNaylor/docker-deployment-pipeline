#!/bin/bash

cd "$(dirname "$0")"

docker-compose kill && docker-compose rm -f

if [[ "$(docker images -q local-image 2> /dev/null)" != "" ]]; then
  docker rmi local-image
fi

docker-compose build && docker-compose up -d

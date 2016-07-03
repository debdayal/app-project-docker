#!/bin/bash

echo "Installing and starting applications ..."
eval "$(docker-machine env --swarm sun)"
COMPOSE_HTTP_TIMEOUT=200
docker-compose -p app up -d

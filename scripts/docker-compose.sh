#!/bin/bash



source .env

docker-compose \
    -f docker-compose.networks.yml \
    -f docker-compose.db.yml \
    -f docker-compose.api.yml \
    -f docker-compose.web.yml \
    -f docker-compose.proxy.yml \
    "$@"

#!/bin/bash

source hub.env && \
    docker-compose \
    -f docker-compose.api.yml \
    -f docker-compose.db.yml \
    -f docker-compose.local.yml \
    "$@"

#!/bin/bash

./fix-permissions.sh
source stag.env && docker-compose -f docker-compose.networks.yml -f docker-compose.backend.yml -f docker-compose.front-end.yml down
source stag.env && docker-compose -f docker-compose.networks.yml -f docker-compose.backend.yml -f docker-compose.front-end.yml up -d
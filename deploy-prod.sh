#!/bin/bash

./fix-permissions.sh
source prod.env && docker-compose -f docker-compose.backend.yml -f docker-compose.front-end.yml down
source prod.env && docker-compose -f docker-compose.backend.yml -f docker-compose.front-end.yml up -d



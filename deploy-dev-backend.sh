#!/bin/bash

source dev.env && docker-compose -f docker-compose.backend.yml -f docker-compose.backend.dev.yml down
sudo rm -r data # Forces recreation of database every time
source dev.env && docker-compose -f docker-compose.backend.yml -f docker-compose.backend.dev.yml up


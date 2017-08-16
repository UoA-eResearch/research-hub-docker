#!/bin/bash

rosinstall ../ prod.rosinstall
source prod.env && docker-compose -f docker-compose.networks.yml -f docker-compose.backend.yml -f docker-compose.front-end.yml build
#!/bin/bash

rosinstall ../ stag.rosinstall
source stag.env && docker-compose -f docker-compose.backend.yml -f docker-compose.front-end.yml build
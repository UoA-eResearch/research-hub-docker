#!/bin/bash

rosinstall ../ dev.rosinstall
source dev.env && docker-compose -f docker-compose.backend.yml -f docker-compose.backend.dev.yml build


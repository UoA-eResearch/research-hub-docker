#!/bin/bash

# For some reason my user is part of others, so we need to set the correct permissions for docker to be able to read and execute certain files
chmod o+r database.xlsx
chmod o+r schema.sql
chmod o+r seed_db.py
chmod o+rx seed-db.sh
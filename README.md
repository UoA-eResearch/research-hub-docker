# research-hub-deploy
The Research Hub's deployment scripts

## Prerequisites

* Install docker-ce and docker-compose on your system.
* Ensure you have copied ssl certificates (server.crt, server-ca.crt and server.key ) into the project directory.
* Edit the environment variables in staging.env and production.env.
* Edit the settings (e.g. the database password) in staging.properties and production.properties.

## Deploy the staging instance

Run the following commands:

```bash
cd research-hub-deploy
chmod 777 schema.sql
source staging.env
sudo -E docker-compose -f docker-compose.yml pull
sudo -E docker-compose -f docker-compose.yml up -d
```

## Deploy the production instance

Run the following commands:

```bash
cd research-hub-deploy
chmod 777 schema.sql
source production.env
sudo -E docker-compose -f docker-compose-production.yml pull
sudo -E docker-compose -f docker-compose-production.yml up -d
```

## TODO

* Replace docker-compose-production.yml with docker-compose.yml after using new REST api in production.
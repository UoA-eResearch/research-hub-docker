# research-hub-deploy
The Research Hub's deployment scripts

## Prerequisites

* Ensure you have copied the ssl certificates into the project directory

## Setup staging instance

To run the staging instance:
```bash
sudo docker-compose -f docker-compose-staging.yml run
```

chmod 777 schema.sql

mysql -h db -P 3306 -uroot -p 123

    volumes:
      - ./${TAG}.properties:/application.properties
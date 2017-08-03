# Research Hub deployment project
The Research Hub's automated build scripts, created with Docker and Docker Compose.

## Prerequisites
* Ubuntu 16.04
* [docker-ce](https://docs.docker.com/engine/installation/linux/ubuntu/) and [docker-compose](https://docs.docker.com/compose/install/)
* rosinstall, which is used to clone the project repositories and checkout the required versions depending on the environment,
i.e. development, staging and production. To install rosinstall execute the following command: `sudo pip install -U rosinstall`.

## Setup your workspace
Create a directory on your machine, e.g. research_hub:
```bash
mkdir ~/workspace/research-hub/
```

Navigate to the folder you just created and clone the research-hub-deploy project:
```bash
cd ~/workspace/research-hub/
git clone https://github.com/UoA-eResearch/research-hub-deploy.git
```

Navigate to the research-hub-deploy project:
```bash
cd research-hub-deploy
```

**Important**: ensure that you have copied the seed database excel file (database.xlsx) into research-hub-deploy.

## Development
To build REST API and database, run the following command:
```bash
./build-dev-backend.sh
```

Then run the following command to run them:
```bash
./deploy-dev-backend.sh
```

To verify that the REST API is working, run the following command:
```bash
curl localhost:8080/content/1
{"id":1,"name":"Research Virtual Machines","summary":"Support for specialised computing needs across different operating systems, interactive workflows, and externally facing services via the web.","description":"Many researchers need specialised computing facilities that support a variety of different operating systems, allow interactive use (rather than relying on a typical HPC batch scheduler), run for extended periods of time (months), and provide externa..."
```

## Deploy to staging or production
* Ensure you have copied the ssl certificates (server.crt, server-ca.crt and server.key) into the *research-hub-deploy* project directory.
* Edit the environment variables in *stag.env* and *prod.env*.
* To change the versions of each repository that are checked out for a particular environment, edit stag.rosinstall or prod.rosinstall.

### Staging
To build the staging instance, run the following command:
```bash
./build-stag.sh
```

To deploy the staging instance, run the following command:
```bash
./deploy-stag.sh
```

### Production
To build the production instance, run the following command:
```bash
./build-prod.sh
```

To deploy the staging instance, run the following command:
```bash
./deploy-prod.sh
```

## Seeding a database manually
Install the following dependencies:
```bash
sudo apt-get install libmysqlclient-dev
pip3 install pandas mysqlclient xlrd
```

From the *research-hub-deploy* project directory, run the following command:
```bash
source dev.env && python3 seed_db.py
```

## Troubleshooting
##### 1. Permission denied errors in mysql-auto-backup container:

```bash
db_1  | /entrypoint.sh: running /docker-entrypoint-initdb.d/seed-db.sh
db_1  | /entrypoint.sh: line 179: /docker-entrypoint-initdb.d/seed-db.sh: Permission denied
```

Ensure your user the right to read and or execute certain files, see fix-permissions.sh


##### 2. Permission denied while running docker
```
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.27/containers/json: dial unix /var/run/docker.sock: connect: permission denied
```
 
Follow [these steps](https://docs.docker.com/engine/installation/linux/linux-postinstall/#manage-docker-as-a-non-root-user) so that Docker will run without root.

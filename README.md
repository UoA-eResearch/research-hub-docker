# Research Hub deployment project
The Research Hub's automated build scripts, created with Docker and Docker Compose.

## Prerequisites
* Ubuntu 16.04
* [docker-ce](https://docs.docker.com/engine/installation/linux/ubuntu/) and [docker-compose](https://docs.docker.com/compose/install/)
* rosinstall, which is used to clone the project repositories and checkout the required versions depending on the environment,
i.e. development, staging and production. To install rosinstall execute the following command: `sudo pip install -U rosinstall`.

## Setup your workspace
Create a directory on the VM, e.g. research_hub:
```bash
mkdir /data/research-hub/
```

Navigate to the folder you just created and clone the research-hub-deploy project:
```bash
cd /data/research-hub/
git clone https://github.com/UoA-eResearch/research-hub-deploy.git
```

Navigate to the research-hub-deploy project:
```bash
cd research-hub-deploy
```

**Important**: ensure that you have copied the seed database excel file (database.xlsx) into /data/config.

## Development
To build REST API and database, run the following command:
```bash
./scripts/docker-compose.backend.local.sh build
```

Then run the following command to run them:
```bash
./scripts/docker-compose.backend.local.sh up
```

To verify that the REST API is working, run the following command:
```bash
curl localhost:8080/content/1
{"id":1,"name":"Research Virtual Machines","summary":"Support for specialised computing needs across different operating systems, interactive workflows, and externally facing services via the web.","description":"Many researchers need specialised computing facilities that support a variety of different operating systems, allow interactive use (rather than relying on a typical HPC batch scheduler), run for extended periods of time (months), and provide externa..."
```

## Runnning on dev, test or prod
TODO: this should be done with a CI tool.

* Customise the environment variables in `hub.env` file, for a particular environment.
* Ensure you have copied the ssl certificates (server.crt, server-ca.crt and server.key) into the /data/config project directory.
* To change the versions of each repository that are checked out for a particular environment, make a hub.rosinstall file
and edit their version numbers (example can be found in hub.rosinstall.example).
* Ensure that you have copied the seed database excel file (database.xlsx) into /data/config.

To check out the source for all projects:
```bash
./scripts/checkout.sh
```
To build:
```bash
./scripts/docker-compose.sh build
```

To run in foreground:
```bash
./scripts/docker-compose.sh up
```

To stop:
```bash
./scripts/docker-compose.sh down
```

To run in the background:
```bash
./scripts/docker-compose.sh up -d
```

## Seeding a database manually
Install the following dependencies:
```bash
sudo apt-get install libmysqlclient-dev
pip3 install pandas mysqlclient xlrd
```

From the *research-hub-deploy* project directory, run the following command:
```bash
source hub.env && python3 ./scripts/seed_db.py
```

## Troubleshooting
##### 1. Permission denied errors in mysql-auto-backup container:

```bash
db_1  | /entrypoint.sh: running /docker-entrypoint-initdb.d/seed-db.sh
db_1  | /entrypoint.sh: line 179: /docker-entrypoint-initdb.d/seed-db.sh: Permission denied
```

Ensure your user has the right to read and or execute these files.


##### 2. Permission denied while running docker
```
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.27/containers/json: dial unix /var/run/docker.sock: connect: permission denied
```
 
Follow [these steps](https://docs.docker.com/engine/installation/linux/linux-postinstall/#manage-docker-as-a-non-root-user) so that Docker will run without root.

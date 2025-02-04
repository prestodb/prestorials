# Presto in Docker Compose
This is a sample setup to run a Presto cluster with 1 coordinator and 2 workers using either [Minio](/docker-compose/minio/readme), [Mysql](/docker-compose/mysql/readme), [MongoDB](/docker-compose/MongoDB/readme), or [local filesystem](/docker-compose-native/local-fs/readme) for storage.

## Requirements
* Mac OS X or Linux, with minimum 10G memory and 50G free disk space
* Docker Desktop 4.10.1 (Engine: 24.0.2, Compose: v2.18.1) and above
* At least 10G free memory on your machine

## Update catalog configurations
* Update `mysql.properties`, `postgresql.properties`, `hive.properties` and/or `glue.properties` if you need to.
* Add catalogs of other connectors if you need to.
* Update `volumes` sections in `docker-compose.yaml` to mount catalog files accordingly.
* Update `environment` sections in `docker-compose.yaml` to inject required environment variables into Presto proceses.

## Start a Presto cluster
Open a terminal, change into one of the subdirectories in ($REPO_ROOT/docker-compose/), and refer to the respective Readme for further instructions. Spinup a Presto cluster with docker compose file `docker-compose.yaml` using:

    docker compose -v -f docker-compose.yaml up

You can monitor the logs of different containers in the terminal and Docker Desktop UI.

## Access Presto Web Console
    http://127.0.0.1:8080

## Run Presto CLI
    docker exec -it coordinator /opt/presto-cli --server http://127.0.0.1:8080

## Stop and delete the cluster
    ctrl-c 
    docker compose down

## Notes
* The cluster performs better on Linux because the docker image is built to run on linux/amd64.
* A container may hang when running on Mac OS X. You can restart it in either terminal or Docker Desktop.

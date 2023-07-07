# Presto in Docker Compose
This is a sample setup to run a Presto cluster with 1 coordinator and 2 workers.

## Requirements
* Mac OS X or Linux, with minimum 10G memory and 50G free disk space
* Docker Desktop 4.10.1 (Engine: 24.0.2, Compose: v2.18.1) and above

## Update catalog configurations
* Update `mysql.properties`, `postgresql.properties`, `hive.properties` and/or `glue.properties` if you need to.
* Add catalogs of other connectors if you need to.
* Update `volumes` sections in `docker-compose.yaml` to mount catalog files accordingly.
* Update `environment` sections in `docker-compose.yaml` to inject required environment variables into Presto proceses.

## Start a Presto cluster
Open a terminal, and change into this directory.

    docker compose up
You can monitor the logs of different containers in the terminal and Docker Desktop UI.

## Access Presto Web Console
    http://127.0.0.1:8080

## Run Presto CLI
    docker exec -it cli /opt/presto-cli --server http://10.18.0.8:8080

## Stop and delete the cluster
    ctrl-c 
    docker compose down

## Notes
* The cluster perfroms better on Linux because the docker image is built to run on linux/amd64.
* A container may hang when running on Mac OS X. You can restart it in either terminal or Docker Desktop.

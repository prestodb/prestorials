# Getting Started with Docker setup with Presto coordinator, Prestissimo worker, Hive, MinIO

This Docker setup has:
1. A Presto coordinator to coordinate Presto or Prestissimo workers
2. A Prestissimo worker to run the queries
3. A MinIO container to provide out of the box local S3 storage. 
4. A Hive container to connect MinIO with Presto

## Currently supported platforms
Mac (x86 Intel and arm64)
Linux (Ubuntu / CentOS)

Everything should already be set up to run for this Docker setup. To run this Docker setup, make sure you're in this current directory `/docker-compose-native` and run `docker compose up` to bring up the Docker containers and use the setup. 

It does take some time for the Prestissimo worker to be hooked up with the Presto coordinator. You can check if it's connected or not by going to http://localhost:8080/ui/ and it should show a dashboard with current active workers and other stats.

To bring the Docker containers down, run `docker compose down` or `ctrl+c` on the current terminal where you ran `docker compose up`.

The file `docker-compose-arm64.yml` uses the `linux/arm64` Presto images and the file-based hive metastore. This docker compose file can be used on silicon based Macs with command `docker compose -f docker-compose-arm64.yml up`. The config for file-based hive connector is present in `hive_file.properties` and requires the data to be copied into the directory `prestissimo/data` beforehand. 
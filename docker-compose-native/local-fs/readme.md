# Getting Started with Presto using local filesystem

This Docker compose setup deploys a Presto C++ cluster with 1 coordinator and 2 workers which uses file based hive metastore.
Based on whether your CPU architecture is x64 or aarch64, use the docker compose file docker-compose-amd64.yaml or docker-compose-arm64.yaml respectively.

For x64:

    docker compose -v -f docker-compose-amd64.yaml up

For aarch64:

    docker compose -v -f docker-compose-arm64.yaml up

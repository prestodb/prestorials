# Getting Started with Presto using local filesystem

This Docker compose setup deploys a Presto Java cluster with 1 coordinator and 2 workers which uses file based hive metastore. 
Based on whether your CPU architecture is x64 or aarch64, use the docker compose file docker-compose-amd64.yaml or docker-compose-arm64.yaml respectively.

For x64:

    docker compose -v -f docker-compose-amd64.yaml up

For aarch64:

    docker compose -v -f docker-compose-arm64.yaml up

To setup a single node Presto cluster, where the Presto server acts both as a coordinator and worker: 

    docker compose -v -f docker-compose-single-node.yaml up

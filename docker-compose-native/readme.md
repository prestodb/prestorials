# Getting Started with Presto C++

This tutorial uses [docker compose](https://docs.docker.com/compose/) to deploy a Presto C++ cluster with 1 coordinator and 2 workers. [Minio](/docker-compose-native/minio/readme.md) or [local filesystem](/docker-compose-native/local-fs/readme.md) can be used for storage, please refer to the respective Readme for instructions.

For a GPU-accelerated cluster that offloads query execution to an NVIDIA GPU via cuDF, see the [GPU prestorial](/docker-compose-native/gpu/readme.md).

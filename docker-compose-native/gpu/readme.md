# Getting Started with GPU-accelerated Presto C++

This Docker compose setup deploys a GPU-accelerated Presto C++ cluster with 1 coordinator and 1 GPU-enabled worker, using a file based Hive metastore over the local filesystem.

The worker uses the new GPU-enabled native image and offloads query execution to an NVIDIA GPU through [cuDF](https://docs.rapids.ai/api/cudf/stable/) (part of [RAPIDS](https://rapids.ai/)), which is integrated into the Velox execution engine. The coordinator currently runs a custom image with the latest required open-source patches.

This prestorial uses the following images:

- `prestodb/presto:coordinator-gpu-nightly` for the coordinator
- `prestodb/presto-native:gpu-nightly` for the worker

These images are experimental, expected to change often and provided for development purposes, research or enthusiasts. It is recommended to produce the tables/data with another prestorial and use this one for data analysis.

## Requirements

In addition to the [general requirements](/readme.md) of this repository, GPU acceleration requires:

- An NVIDIA GPU with up-to-date NVIDIA drivers
- The [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) so Docker can expose the GPU to the worker container
- Docker configured to use the NVIDIA runtime

You can confirm the GPU is visible to Docker with:

    docker run --rm --gpus all nvidia/cuda:12.4.1-base-ubuntu22.04 nvidia-smi

This prestorial currently provides an `amd64` (x64) compose file only.

## Running the cluster

For x64:

    docker compose -f docker-compose-amd64.yaml up

The coordinator is exposed on port `8080` and the worker on port `8082`. Once the cluster is up, open the Presto UI at http://localhost:8080 or connect with the Presto CLI:

    presto --server localhost:8080 --catalog hive

## How GPU acceleration is configured

The worker enables cuDF in `etc_worker/config.properties`:

- `cudf.enabled=true` turns on GPU execution in the native worker. On a CPU-only build this setting is ignored, so the same configuration degrades gracefully.
- `cudf.exchange`, `cudf.intra_node_exchange` and related properties control GPU-aware data exchange; in this single-worker setup exchange stays disabled.
- Parquet reader options in `etc_worker/catalog/hive.properties` (`cudf.hive.use-experimental-reader`, `cudf.hive.use-buffered-input`, batched splits) tune file reading for the GPU path.

In `docker-compose-amd64.yaml` the worker reserves the GPU through Docker's device reservations:

    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              device_ids: ["0"]
              capabilities: [gpu]

Adjust `device_ids` if you want the worker to use a different GPU.

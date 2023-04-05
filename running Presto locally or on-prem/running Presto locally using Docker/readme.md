# Getting Started with Presto locally using Docker

## Introduction

This folder example files and steps for standing up Presto using Docker Desktop.
Soon we will have a video walk-through as well as a written walk through in blog form.

1. [Using Docker Desktop](#Running Presto using Docker Desktop)
2. [Using Docker CLI](#Running Presto using Docker CLI)

## Requirements

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) or [Docker CLI](https://docs.docker.com/get-docker/) installed

## Running Presto using Docker Desktop

### Network and container staging
1. Open a Terminal and start by creating a network for the nodes to communicate with each other
```docker network create presto_network```
2. Next we need to download a container, for this exercise we will use the Presto Sandbox container provided by [Ahana](https://ahana.io/)
```docker pull ahanaio/prestodb-sandbox```

### Setup the Coordinator
```docker run -d -p 8080:8080 -it --net presto_network --name coordinator ahanaio/prestodb-sandbox```
1. Open Docker Desktop and select the **Containers** section on the left
2. You should see the coordinator container running, click on the name ```coordinator```
3. You should see the Logs, click on the **Terminal** tab
4. We need to edit the configuration to set this container as a coordinator only, enter the following command
```vi /opt/presto-server/etc/config.properties```
5. Hit the ```i``` key to edit the file shown
6. Set the include-scheduler line to false ```node-scheduler.include-coordinator=false```
7. Hit ```Esc``` then type ```:wq``` and hit ```Enter```
8. Hit the circular arrow restart button towards the top right

### Setup 3 Worker Nodes
1. In your terminal run the following commands to spin up 3 worker nodes with different ports
```
docker run -d -p 8081:8081 -it --net presto_network --name worker1 ahanaio/prestodb-sandbox
docker run -d -p 8082:8082 -it --net presto_network --name worker2 ahanaio/prestodb-sandbox
docker run -d -p 8083:8083 -it --net presto_network --name worker3 ahanaio/prestodb-sandbox
```
1. For each container we need to edit the configuration properties:
   1. Setting them up as worker nodes
   2. Informing them of where the coordinator is
   3. and setting their http port to what we set in the docker run command
2. Open Docker Desktop and select the **Containers** section on the left
3. You should see the worker containers running, click on ```worker1```
4. You should see the Logs, click on the **Terminal** tab
5. Enter the following command
   ```vi /opt/presto-server/etc/config.properties```
6. Hit the ```i``` key to edit the file shown
7. Set coordinator to false ```coordinator=false```
8. Remove the ```node-scheduler.include-coordinator=true``` line
9. Set http.port to 8081 ```http-server.http.port=8081```
10. Remove the ```discovery-server.enabled=true``` line
11. Set the discovery uri to http://coordinator:8080 ```discovery.uri=http://coordinator:8080```
<br>Your file should now look like this
```
coordinator=false
http-server.http.port=8081
discovery.uri=http://coordinator:8080
```
1. Hit ```Esc``` then type ```:wq``` and hit ```Enter```
2. Hit the circular arrow restart button towards the top right 
3. Select the **Containers** section on the left
4. You should see the worker containers running, click on ```worker2```
5. You should see the Logs, click on the **Terminal** tab
6. Enter the following command
   ```vi /opt/presto-server/etc/config.properties```
7. Hit the ```i``` key to edit the file shown
8. Set coordinator to false ```coordinator=false```
9. Remove the ```node-scheduler.include-coordinator=true``` line
10. Set http.port to 8081 ```http-server.http.port=8082```
11. Remove the ```discovery-server.enabled=true``` line
12. Set the discovery uri to http://coordinator:8080 ```discovery.uri=http://coordinator:8080```
    <br>Your file should now look like this
```
coordinator=false
http-server.http.port=8082
discovery.uri=http://coordinator:8080
```
1. Hit ```Esc``` then type ```:wq``` and hit ```Enter```
2. Hit the circular arrow restart button towards the top right
3. Select the **Containers** section on the left
4. You should see the worker containers running, click on ```worker3```
5. You should see the Logs, click on the **Terminal** tab
6. Enter the following command
   ```vi /opt/presto-server/etc/config.properties```
7. Hit the ```i``` key to edit the file shown
8. Set coordinator to false ```coordinator=false```
9. Remove the ```node-scheduler.include-coordinator=true``` line
10. Set http.port to 8081 ```http-server.http.port=8083```
11. Remove the ```discovery-server.enabled=true``` line
12. Set the discovery uri to http://coordinator:8080 ```discovery.uri=http://coordinator:8080```
    <br>Your file should now look like this
```
coordinator=false
http-server.http.port=8083
discovery.uri=http://coordinator:8080
```
1. Hit ```Esc``` then type ```:wq``` and hit ```Enter```
2. Hit the circular arrow restart button towards the top right
3. Click the **Logs** tab for worker3 and wait for ```======== SERVER STARTED ========``` to appear
4. Check that this is showing on the other two worker nodes
5. Once all worker nodes are back online, open a browser window to ```http://localhost:8080/```
6. You should see 3 active workers ready
![Presto Web UI showing 3 active workers](./screenshots/presto_docker_local_ready.png)
*<p align="center">Screenshot of Presto Web UI showing 3 active workers</p>*

Using the steps above you can add as many worker nodes as you need to scale.

## Running Presto using Docker CLI
### Standup the cluster
*coming soon*


## References

- https://github.com/prestodb/presto
- https://www.docker.com/

## Contributing

[//]: # (See the [CONTRIBUTING]&#40;CONTRIBUTING.md&#41; file for how to help out.)

## License


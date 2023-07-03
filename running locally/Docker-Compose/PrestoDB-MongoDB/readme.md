# Querying data from Mongodb using Presto and docker-compose

## Introduction

In this tutorial you will:
1. Run Presto with mongodb using Docker-compose
2. Connecting Prestodb, mongodb 
3. Creating individual tables in mongodb and prestodb
4. Query data from prestodb to retrieve data from mongodb

## Requirements

Tested in Docker Version 20.x.x, Docker Compose version 1.29.x
##

In order to query MongoDB with Presto, please follow the steps below:

## Step 1: Install Docker and Docker Compose

Make sure you have Docker and Docker Compose installed on your system. You can download and install them from the official Docker website: https://www.docker.com/get-started

### Step 2: Create a Docker Compose file

Open a text editor and create a file named docker-compose.yml.
Add the following content to the file:
```
version: '2'
services:
  presto:
    image: ahanaio/prestodb-sandbox:0.280
    container_name: presto
    volumes:
      - ${PWD}/config/catalog/mongodb.properties:/opt/presto-server/etc/catalog/mongodb.properties
    depends_on:
      - mongodb
    ports:
      - "8080:8080"
    networks:
      - presto-nw
  mongodb:
    image: mongo:6.0.4
    container_name: presto-mongo
    volumes:
      - mongoData:/data/db
    ports:
      - "27017:27017"
    networks:
     - presto-nw
networks:
  presto-nw:
    driver: bridge
volumes:
  mongoData:
~                     
---
```

#### Save the Docker Compose file
-Save the docker-compose.yml file in a directory of your choice.


### Step 3: Start the containers

Open a terminal  and navigate to the directory where you saved the Docker Compose file.
Run the following command to start the containers:

```
docker-compose up 
```

### Step 4: Connecting to MongoDB

Execute the following command in another terminal window.
```
docker exec -it presto-mongo mongosh
```

#### Sample queries to be run on the mongodb container:

The following commands create a collection called “book” and insert two records into it.

```
use presto_to_mongodb;
db.createCollection("book")
db.book.insertOne({"id":1, "book_name":"harry potter" })
db.book.insertOne({"id":2, "book_name":"the wicked king" })
```

### Step 5: Connecting to PrestoDB

Execute the following command in another  terminal window. 
```
docker exec -it presto presto-cli
```

#### Sample queries in Presto querying data from MongoDB

The following command queries all records from the book collection

```
show catalogs;

show schemas in mongodb;
use mongodb.presto_to_mongodb;
select * from book;
```


These steps should help you get started with setting up PrestoDB and MongoDB using Docker Compose.

## References

- https://github.com/prestodb/presto
- [https://www.docker.com/](https://docs.docker.com/compose/)
- https://docs.docker.com/compose/
- https://briefbytes.com/2019/Query-MongoDB-using-SQL-with-Presto/
  
## Contributing

[//]: # (See the [CONTRIBUTING]&#40;CONTRIBUTING.md&#41; file for how to help out.)

## License

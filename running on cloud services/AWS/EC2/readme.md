## Introduction

Presto is an open source, distributed query engine that enables us to perform fast, interactive and analytical type of queries on various sizes of datasets. It is SQL compliant and supports many data sources.



### Installing and using Presto on EC2
This tutorial provides instructions to deploy a single node Presto cluster on an EC2 instance, primarily for learning purposes. Specifically, this article follows the Deploying Presto instructions with some additional useful context. It assumes the reader knows how to provision and SSH into an EC2 instance.
Launch an EC2 Instance. These instructions assume you are using Amazon Linux 2 AIM or 2023 AIM as the operating system.


## SSH into the EC2 Instance. 
```
ssh -i /path/key-pair-name.pem instance-user-name@instance-public-dns-name
```
## Install Java. 

Presto requires Java. You can install as follows
```
sudo yum update -y
sudo amazon-linux-extras install java-openjdk11
```
If this is linux2023, try following steps:
```
sudo dnf update -y
sudo dnf install java-11-amazon-corretto-devel
```

You can verify the installation by checking the Java version.
```
bash-4.2# java --version

openjdk 11.0.18 2023-01-17 LTS
OpenJDK Runtime Environment Corretto-11.0.18.10.1 (build 11.0.18+10-LTS)
OpenJDK 64-Bit Server VM Corretto-11.0.18.10.1 (build 11.0.18+10-LTS, mixed mode)
```
Download and Unarchive Presto. You select your release here: 
https://repo1.maven.org/maven2/com/facebook/presto/presto-server/


This example uses 0.279.
```
wget <https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.279/presto-server-0.279.tar.gz>
tar -xvf presto-server-0.279.tar
```

Add Configuration Files to etc directory. You need to add the appropriate   configuration files to the etc directory in the installation directory. The following configuration files are known good configuration files for 0.279 on an Amazon Linux EC2 instance.

node.properties

```
node.environment=production
node.data-dir=/var/presto/data
```

jvm.config

```
 -server
-Xmx16G
-XX:+UseG1GC
-XX:G1HeapRegionSize=32M
-XX:+UseGCOverheadLimit
-XX:+ExplicitGCInvokesConcurrent
-XX:+HeapDumpOnOutOfMemoryError
-XX:OnOutOfMemoryError=kill -9 %p
-Djdk.attach.allowAttachSelf=true
```

config.properties

```
coordinator=true
node-scheduler.include-coordinator=true
http-server.http.port=8090
query.max-memory=10GB
query.max-memory-per-node=1GB
discovery-server.enabled=true
discovery.uri=http://127.0.0.1:8090
```

For distributed configuration, add following config file for worker node
```
coordinator=false
http-server.http.port=8090
query.max-memory=10GB
query.max-memory-per-node=1GB
discovery.uri=http://<coordinator public ip>:8090
```
For distributed configuration, catalogs properties are needed for each worker node


### Start the Presto Server From the installation directory:


#### Run as daemon (background process): 
```
bin/launcher start
```

#### Run in foreground: 
```
bin/launcher run
```

if running in amazon linux 2023, python2 has been deprecated, you need to package python3 as python
sudo dnf install python-is-python3
Make sure the inbound security rule is set to allow access of the presto discovery port for Custom TCP (in this case 8090), for both coordinator node and worker nodes


#### Verifying the Presto Cluster

Access Presto Console. Using the public IP of the EC2 instance and configured port, you should be able to see the Presto console.

Run a Query Through the Presto CLI. https://ahana.io/docs/connect-via-presto-cli

```
wget<https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/0.281/presto-cli-0.281-executable.jar>
mv presto-cli-0.281-executable.jar presto
chmod +x presto
```
### Enabling the TPCH and TPCDS connector


setup property file for TPCH and TPCDS connector under
```
etc/
├── catalog
│   ├── tpcds.properties
│   └── tpch.properties
├── config.properties
├── jvm.config
└── node.properties

tpch.properties
   connector.name=tpch
tpcds.properties
   connector.name=tpcds
```
### Summary

In conclusion, deploying Presto in the cloud involves several steps to set up and configure the necessary infrastructure. These should help you get started with setting up PrestoDB in the cloud.

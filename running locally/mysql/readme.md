## Introduction
 This document provides instructions to deploy a single node Presto cluster locally, primarily for learning purposes. This deployment is on a MacOS Monterey (M1 ARM chip).
Specifically, this document follows the Presto instructions with some additional useful context.
Link : https://prestodb.io/docs/current/installation/deployment.html

## Prerequisites
#### Note: All of these instructions are required to be run in sh (super user login required)
#### Java runtime environment
Download and install the latest version of JDK from the official Oracle website.

Set the JAVA_HOME environment variable to the JDK installation directory.
You can find your java version (if installed) using:
```
java -version
```
You can find the download here.

https://www.oracle.com/java/technologies/downloads/#java17

Currently, Java 17 was used.

#### Python
version 2.6.x, 2.7.x, or 3.x
You can find your python version (if installed) using:
```
python —version
```
You can find the download here.
https://www.python.org/downloads/

Currently, Python 3.11.2 was used.

#### Download and Unarchive Presto tarball. 
Download the Presto server tarball https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.281/presto-server-0.281.tar.gz and unpack it. 
The tarball contains a single top-level directory, presto-server-281.

I will refer to this directory as the installation directory as we proceed.

### Configuring Presto

Create an etc directory inside the installation directory. This holds the following configuration:


#### Node properties
The node properties file, etc/[node.properties](<http://node.properties>), contains configuration specific to each node. A node is a single installed instance of Presto on a machine. You need add the node.properties files to the etc directory in the installation directory. The following is a minimal etc/node.properties:
```
node.environment=production node.id=ffffffff-ffff-ffff-ffff-ffffffffffff
node.data-dir=/var/Presto/data
```

#### JVM config

The JVM config file, etc/jvm.config, contains a list of command line options used for launching the Java Virtual Machine. The format of the file is a list of options, one per line. These options are not interpreted by the shell, so options containing spaces or other special characters should not be quoted.
The following sample provides a minimal configuration for creating etc/jvm.config:
```
-server -Xmx16G -XX:InitialRAMPercentage=80 
-XX:MaxRAMPercentage=80 
-XX:G1HeapRegionSize=32M 
-XX:+ExplicitGCInvokesConcurrent 
-XX:+ExitOnOutOfMemoryError 
-XX:+HeapDumpOnOutOfMemoryError 
-XX:-OmitStackTraceInFastThrow 
-XX:ReservedCodeCacheSize=512M 
-XX:PerMethodRecompilationCutoff=10000 
-XX:PerBytecodeRecompilationCutoff=10000 -Djdk.attach.allowAttachSelf=true -Djdk.nio.maxCachedBufferSize=2000000 
-XX:+UnlockDiagnosticVMOptions 
-XX:+UseAESCTRIntrinsics
-XX:-G1UsePreventiveGC`
```

#### Config properties

Add the following configuration file in the etc folder as ‘config.properties’. The config properties file, etc/config.properties, contains the configuration for the Presto server. Every Presto server can function as both a coordinator and a worker. A cluster is required to include one coordinator, and dedicating a machine to only perform coordination work provides the best performance on larger clusters. Scaling and parallelization is achieved by using many workers.

The following is a minimal configuration for the coordinator and a single worker:
```
coordinator=true node-scheduler.include-coordinator=true
http-server.http.port=8080 discovery.uri=http://example.net:8080
```
In some cases, the discovery.uri might not resolve depending on your DNS configuration in which case, please use this minimal configuration
```
coordinator=true node-scheduler.include-coordinator=true http-server.http.port=8080
discovery.uri=http://localhost:8080
```
### Catalog properties

Catalogs are registered by creating a catalog properties file in the etc/catalog directory. 

For example, create etc/catalog/jmx.properties with the following contents to mount the jmx connector as the jmx catalog:
```
connector.name=jmx
```


### Start the Presto Server From the installation directory: 

(Either command can be run; as a daemon in the background or in the a foreground) - Run as daemon (background process):
```
bin/launcher start (background)
```
or

```
Run in foreground: bin/launcher run
```
### Command Line interface: (required for querying)
#### Requirements
The CLI requires a Java virtual machine available on the path.
Download Presto-cli-0.281-executable.jar, rename it to Presto, make it executable with chmod +x, and run it to show the version of the CLI:
```
./Presto --version
```
### Running the CLI
The minimal command to start the CLI in interactive mode specifies the URL of the coordinator in the Presto cluster:
```
./Presto --server localhost:8080
```

If successful, you will get a prompt to execute commands. Use the help command to see a list of supported commands. Use the clear command to clear the terminal. To stop and exit the CLI, run exit or quit


### Adding MYSQL connector:
To configure the MYSQL connector, create a catalog properties file etc/catalog/tpch.properties with the following contents:
```
connector.name=mysql
connection-url=jdbc:mysql://example.net:3306
connection-user=root
connection-password=secret
```

The connection-url defines the connection information and parameters to pass to the MySQL JDBC driver. The supported parameters for the URL are available in the MySQL Developer Guide.

For example, the following connection-url allows you to configure the JDBC driver to interpret time values based on UTC as a timezone on the server, and serves as a workaround for a known issue.

```
connection-url=jdbc:mysql://example.net:3306?serverTimezone=UTC
```
The connection-user and connection-password are typically required and determine the user credentials for the connection, often a service user.



### Restart the Presto Server

Run ‘bin/launcher restart’ in the installation directory to restart the Presto server



## Conclusion

You have successfully installed and connected PrestoDB to MySQL. You can now use PrestoDB to query and analyze your MySQL data.

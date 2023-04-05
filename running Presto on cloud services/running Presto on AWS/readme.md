# Getting Started with Presto on Amazon Web Services (AWS)

## Introduction

This folder example files and steps for standing up Presto on AWS.
Soon we will have a video walk-through as well as a written walk through in blog form.

There are four common ways to run Presto on AWS:

1. [Using Elastic MapReduce (EMR)](#Running Presto using EMR)
2. [Using Ahana Cloud](#Running Presto using Ahana Cloud)
3. [Using Marketplace AMI](#Running Presto using Marketplace AMI)
4. [Using Elastic Compute Cloud (EC2)](#Running Presto using EC2)

## Requirements

- An AWS account with admin access on EMR/EC2/etc.
- A Cloud9 IDE workspace created
- An EC2 Key Pair

## Running Presto using EMR

### Provision the cluster
1. Open the AWS Console and navigate to the EMR service
2. Click **Create cluster**
3. Name the cluster ```prestorial_cluster```
4. Under **Application Bundle** select **Presto**
5. If you're using AWS Glue to catalog data, check the **☑️ Use for Presto table metadata** option
   1. *See tutorial for connecting to AWS Glue under the "connecting Presto to data sources" directory of this repo*
6. Remove the **Task** instance group
7. Set the Core instance group size to 2
8. Under **Cluster termination** select manual or an appropriate idle time for your use case.
9. Under **Security configuration and EC2 key pair** Select your EC2 key pair
10. Under **Cluster logs** Select an S3 bucket in the same region as the cluster
11. Under **Amazon EMR service role** select **Create a service role** and choose the appropriate security group, which may be **default**
12. Under **EC2 instance profile for Amazon EMR** choose **Create an instance profile**
13. Under **S3 bucket access** select **Specific S3 buckets or prefixes in your account**
14. Click **Create cluster**
    1. It can take a few minutes to provision the cluster

## Presto Web UI with EMR

*Accessing Presto's web based monitoring UI requires an SSH tunnel to the EC2 instances in the cluster you just stood up.  In this tutorial we will use Dynamic Port Forwarding and a browser extension for proxy management to accomplish this.*

### ***Steps for Linux/Unix/MacOS***
#### Run the following in your Terminal
   - ```ssh -i /path/to/myEC2KeyPair.pem -N -D 8157 hadoop@ec2-###-##-##-###.compute-1.amazonaws.com```
   - If this is your first time it will prompt you if you want to continue connecting, type ```yes``` and hit enter
   - This will not return a response, leave the terminal open
#### Install and configure SwitchyOmega for Chrome or Brave
   1. Search [Chrome Extensions](https://chrome.google.com/webstore/category/extensions) for ```SwitchyOmega```
   2. Click **add to Chrome/Brave**
   3. Click **New profile** on the left
   4. Set ```emr-socks-proxy``` as the name 
   5. Select **PAC profile** (Proxy Auto-Configuration)
   6. Click **Create** 
   7. In the **PAC Script** text field, replace the contents with the following script.

```
function FindProxyForURL(url, host) { 
if (shExpMatch(url, "*ec2*.amazonaws.com*")) return 'SOCKS5 localhost:8157';
if (shExpMatch(url, "*ec2*.compute*")) return 'SOCKS5 localhost:8157';
if (shExpMatch(url, "http://10.*")) return 'SOCKS5 localhost:8157';
if (shExpMatch(url, "*10*.compute*")) return 'SOCKS5 localhost:8157';
if (shExpMatch(url, "*10*.amazonaws.com*")) return 'SOCKS5 localhost:8157';
if (shExpMatch(url, "*.compute.internal*")) return 'SOCKS5 localhost:8157';
if (shExpMatch(url, "*ec2.internal*")) return 'SOCKS5 localhost:8157';
return 'DIRECT';
}
```
   1. *NOTE: Replace 8157 with your port number if you specified a different number when you set up your tunnel*
   2. Under **Actions** on the left, click **Apply changes**
   3. In the Chrome/Brave toolbar, click the extension icon
   4. Select **SwitchyOmega** and select the ```emr-socks-proxy``` profile

#### Allow inbound SSH from trusted sources

1. Navigate to the [Amazon EMR console](https://console.aws.amazon.com/elasticmapreduce/)
2. Select the cluster you created earlier
3. Under **Properties** tab locate the **Network and security** section
4. Under **EC2 security groups (firewall)** you should see **Primary node** ***EMR managed security group***
5. Click the link below to open the security group 
6. Under the **Inbound rules** tab click **Edit inbound rules
7. Scroll to the bottom and click **Add rule** and set the following
   1. ***Type***: **SSH**
   2. ***Source Type***: **My IP**
8. Click **Save rules**

Congratulations!  You should now be able to access the Presto web UI from:
```
http://master-public-dns-name:8889/
```
Which should show 2 active workers

![Presto Web UI showing 2 active workers](./screenshots/prestowebui_online.png)
*<p align="center">Screenshot of Presto Web UI showing 2 active workers</p>*

### ***Steps for Windows***

*coming soon*

## Running Presto using Ahana Cloud

*coming soon*

## Running Presto using Marketplace AMI

*coming soon*

## Running Presto using EC2

*coming soon*


## References

- https://console.aws.amazon.com
- https://github.com/prestodb/presto

## Contributing

[//]: # (See the [CONTRIBUTING]&#40;CONTRIBUTING.md&#41; file for how to help out.)

## License


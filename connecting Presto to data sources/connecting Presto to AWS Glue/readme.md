# Connecting Presto to AWS Glue

## Introduction

This folder contains example files and steps for connecting Presto on AWS Glue.
Soon we will have a video walkthrough as well as a written walk through in blog form.

## Requirements

- An AWS account with admin access on EMR/EC2/etc.
- A Cloud9 IDE workspace created
- An EC2 Key Pair
- An S3 bucket with CSV or other data
  - Presto expects similar schemas to be in the same directory
  - If you are working with multiple data sets, separate them in S3 into different directories
  - Essentially, all files in a directory must have the same schema

## Quick Start

### Create a glue crawler:

1. In the AWS Console navigate to AWS Glue 
2. On the left select **Data Catalog** and then **Crawlers** and then click **Create crawler**
3. Put ```prestorial_crawler``` for the **Name** under **Crawler Details** or anything that fits your planned use case
4. Click **Next**
4. On the **Choose data sources and classifiers** screen, click **Add a data source**
5. Under Add a data store section, choose **S3** from the **Data source** drop-down Choose a data store
6. Under **S3 path** either enter your full path or click **Browse S3** and navigate to your data bucket
7. Click **Next**
7. Below **Existing IAM role** select **Create an IAM role** and provide a name for the IAM role, for example ```prestorial_setup_role```
8. Click **Next**
9. On the **Set output and scheduling** screen, under **Target database** click **Add database**
10. Name the database something relevant to your use case or ```prestorial_db``` for now and click **Create database**
8. Back on the **Set output and scheduling** screen towards the bottom, under **Crawler schedule** set the **Frequency** dropdown to **On demand**
9. Click **Next**
10. Review the steps and if everything looks correct click **Create crawler**

### Run the crawler:

1. You should now be looking at the console for the crawler you just created
2. Towards the top, click **Run crawler**
3. Towards the bottom wait for the status for the run to show as **Completed**
4. On the left navigate to **Data catalog / Databases / Tables**
5. If you don't see tables created for your data you may need to click the refresh circular arrow
6. Open each of the tables created and verify that each column has been set to the correct data type
   1. AWS Glue tries its best to guess what the data for each field is but will typically default to string if it's unsure
2. Edit the schema to correct any mistakes the Glue made

### Setup Glue Connector in Presto



## [2] Running Presto using Ahana Cloud
## [3] Using Marketplace AMI
## [4] Using Elastic Compute Cloud (EC2)

## References

- https://prestodb.io
- https://github.com/prestodb/presto

## Contributing

[//]: # (See the [CONTRIBUTING]&#40;CONTRIBUTING.md&#41; file for how to help out.)

## License


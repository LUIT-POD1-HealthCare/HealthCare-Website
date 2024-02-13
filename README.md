# HealthCare-Website
Transition HealthCare North's website from its current costly and high-maintenance cloud server setup to a more economical and efficient AWS service, specifically leveraging a static S3 website.


# Naming Standards
This section is designed to implement a clear and concise set of naming standards for AWS resources, as well as a folder structure for this repository.

## Resource naming conventions
Name the resources in the order listed below separated by a hyphen:

1. Project name - Healthcare Website abbreviated to **hcw**
2. Purpose/description - For example: **terraform-state** or **website-bucket**
3. Environment (if applicable) - **dev** or **prod**
4. Extra characters if necessary with S3 buckets to keep names unique

The same bucket can be used for all state files, so there is no need for **dev** or **prod** with this resource, same goes for the DynamoDB table for state locking

### Example:
An S3 bucket for the website in the dev environment could be named:

hcw-website-bucket-dev-87332

## Repository Folder Structure
Given that terraform configurations will exist for multiple configurations and environments, create a separate folder for each configuration and environment. Place a descriptive name followed by either the **dev** or **prod** environments. 

A suitable name for the folder containing the CI pipeline for the Prod environment could be:

CI_pipeline_prod

## Terraform Remote state with distinct state files
The same bucket can be used for multiple state files, by specififying the desired S3 key in each configuration like so:

~~~
terraform {
  backend "s3" {
    bucket = "hcw-terraform-state-82734"
    encrypt = true    
    dynamodb_table = "hcw-state-locks"
    key    = "website-bucket/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
~~~

In the above example, a similar naming convention has been used for the bucket key, with the exception of the project name, since that will be present in the bucket name itself. 
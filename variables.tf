# Define the AWS region where resources will be created.
variable "aws_region" {
  type    = string      # Data type of the variable.
  default = "us-east-1" # Default value set to the US East (N. Virginia) region.
}

# Specify the name of the S3 bucket to be created.
variable "bucket_name" {
  description = "Name of the bucket" # Description of the variable.
  type        = string               # Data type of the variable.
  default     = "hcw-bucket-test"    # Default name for the development S3 bucket.
}

# For these variable code to work, Add terraform.tfvars file and place only the variable value in it.
variable "aws_profile" {
  description = "Name of the AWS Profile"
  type        = string
}

variable "aws_access_key_id" {
  description = "Access key"
  type        = string

}

variable "aws_secret_access_key" {
  description = "Secret Access Key"
  type        = string
}

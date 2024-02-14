# Define the AWS region where resources will be created.
variable "aws_region" {
  type    = string  # Data type of the variable.
  default = "us-east-1"  # Default value set to the US East (N. Virginia) region.
}

# Specify the name of the S3 bucket to be created.
variable "bucket_name" {
  description = "Name of the bucket"  # Description of the variable.
  type        = string  # Data type of the variable.
  default     = "hcw-bucket-dev"  # Default name for the development S3 bucket.
}

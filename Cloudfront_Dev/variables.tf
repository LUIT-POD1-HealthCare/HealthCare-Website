variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the bucket"
  type        = string
  default     = "hcw-website-bucket-prod-2024-cftest"
}

# For these variable code to work, Add terraform.tfvars file and place only the variable value in it.
variable "aws_profile" {
  description = "Name of the AWS Profile being used"
  type        = string
}

variable "aws_access_key_id" {
  description = "Access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "Secret Access Key"
  type        = string
  sensitive   = true
}

# variable for origin id usually s3 bucket location where we have s3 bucket website
variable "origin_id" {
  type    = string
  default = "hcw-website-bucket-prod-2024-cftest"
}
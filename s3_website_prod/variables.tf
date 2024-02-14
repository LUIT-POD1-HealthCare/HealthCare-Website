variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the bucket"
  type        = string
  default     = "hcw-website-bucket-prod-2024"
}
############################################
# Global
############################################

variable "aws_profile" {
  description = "AWS Profile"
  default     = "temp"

}

variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "project" {
  description = "Abbreviation of the project name HealthCare Website"
  default     = "hcw"
}

variable "environment" {
  description = "Environment"
  default     = "dev"
}

############################################
# CodePipeline
############################################

variable "codepipeline_role" {
  description = "ARN of the IAM role to be used by CodePipeline"
  default     = "arn:aws:iam::730335364473:role/CodePipelineServiceRole"
}

variable "pipeline_type" {
  description = "Type of pipeline"
  default     = "V2"
}

variable "connection_arn" {
  description = "ARN of the connection to the GitHub repository"
  default     = "arn:aws:codestar-connections:us-east-1:730335364473:connection/835afda3-7a72-4343-960c-fa7c249863d9"
}

############################################
# GitHub
############################################

variable "github_owner" {
  description = "Organization or GitHub username"
  default     = "LUIT-POD1-HealthCare"
}

variable "repository" {
  description = "GitHub repository"
  default     = "HealthCare-Website"
}

variable "github_branch" {
  description = "GitHub branch"
  default     = "main"
}

############################################
# S3
############################################

variable "bucket_name_website" {
  description = "Name of the bucket to host the HealthCare Website"
  default     = "hcw-bucket-dev" # Change to hcw-website-bucket-prod-2024 for production
}

variable "bucket_name_artifacts" {
  description = "Name of the bucket to store artifacts"
  default     = "hcw-artifacts-bucket-2024"
}
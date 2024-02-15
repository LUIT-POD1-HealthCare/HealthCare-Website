############################################
# Global
############################################

variable "aws_profile" {
  description = "AWS Profile"
  default     = "admin-profile"

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
  default     = "arn:aws:iam::835656321421:role/service-role/AWSCodePipelineServiceRole-us-east-1-hcw-pipeline-test4"
}

variable "pipeline_type" {
  description = "Type of pipeline"
  default     = "V2"
}

variable "connection_arn" {
  description = "ARN of the connection to the GitHub repository"
  default     = "arn:aws:codestar-connections:us-east-1:835656321421:connection/d5b0d3df-e03e-403c-a2ca-b210c159e4be"
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
  default     = "pipeline_dev"
}

############################################
# S3
############################################

variable "bucket_name_website" {
  description = "Name of the bucket to host the HealthCare Website"
  default     = "hcw-bucket-test-1234"
}

variable "bucket_name_artifacts" {
  description = "Name of the bucket to store artifacts"
  default     = "hcw-artifacts-bucket-2024"
}
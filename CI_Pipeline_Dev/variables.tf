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
  default     = "v1"
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

variable "github_token" {
  description = "GitHub Token for CodePipeline access"
  sensitive   = true
}

variable "github_branch" {
  description = "GitHub branch"
  default     = "main"
}
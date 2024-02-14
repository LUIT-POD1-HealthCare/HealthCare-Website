#####################################
# Provider
#####################################

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

#####################################
# Pipeline
#####################################

resource "aws_codepipeline" "pipeline" {
  name          = "${var.project}-pipeline-${var.environment}"
  role_arn      = var.codepipeline_role
  pipeline_type = var.pipeline_type

  artifact_store {
    location = "REPLACE_ME"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"

      configuration = {
        Owner      = var.github_owner
        Repo       = var.repository
        Branch     = var.github_branch
        OAuthToken = var.github_token
      }
    }
  }

  stage {
    name = "Build"

    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["source_output"]
      version         = "1"

      configuration = {
        ProjectName = "aws-codepipeline-s3-aws-codedeploy_linux"
      }
    }
  }
  stage {
    name = "Unit_Tests"

    action {
      name = "Unit_Tests"
      category = "Test"
      owner = "REPLACE_ME"
      provider = "REPLACE_ME"
      version = "REPLACE_ME"
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      input_artifacts = ["source_output"]
      version         = "1"

      configuration = {
        BucketName = "REPLACE_ME"
        Extract    = "false"
        ObjectKey  = "REPLACE_ME"
        KMSEncryptionKeyARN = "REPLACE_ME"
      }
    }
  }
}

#####################################
# CodeBuild
#####################################

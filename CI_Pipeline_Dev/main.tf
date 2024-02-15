#####################################
# Provider
#####################################

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

#####################################
# Artifact Store
#####################################

resource "aws_s3_bucket" "artifact_store" {
  bucket        = var.bucket_name_artifacts
  force_destroy = true

}

resource "aws_s3_bucket_lifecycle_configuration" "artifact_store_lifecycle" {
  bucket = aws_s3_bucket.artifact_store.id
  rule {
    id     = "expire_artifacts"
    status = "Enabled"
    expiration {
      days = 1
    }

  }
}

resource "aws_s3_bucket_ownership_controls" "artifact_store_controls" {
  bucket = aws_s3_bucket.artifact_store.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "artifact_store_versioning" {
  bucket = aws_s3_bucket.artifact_store.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_policy" "artifact_store_policy" {
  bucket = aws_s3_bucket.artifact_store.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "SSEAndSSLPolicy",
    "Statement" : [
      {
        "Sid" : "DenyUnEncryptedObjectUploads",
        "Effect" : "Deny",
        "Principal" : "*",
        "Action" : "s3:PutObject",
        "Resource" : "arn:aws:s3:::${aws_s3_bucket.artifact_store.id}/*",
        "Condition" : {
          "StringNotEquals" : {
            "s3:x-amz-server-side-encryption" : "aws:kms"
          }
        }
      },
      {
        "Sid" : "DenyInsecureConnections",
        "Effect" : "Deny",
        "Principal" : "*",
        "Action" : "s3:*",
        "Resource" : "arn:aws:s3:::${aws_s3_bucket.artifact_store.id}/*",
        "Condition" : {
          "Bool" : {
            "aws:SecureTransport" : "false"
          }
        }
      }
    ]
  })
}

#####################################
# Pipeline
#####################################

# Configuration works, but a manual connection is required at https://console.aws.amazon.com/codesuite/settings/connections
# Once connection to repository is made, the connection ARN needs to be inserted into line 61 of variables.tf
# Also need to figure out how to filter files and triggers
resource "aws_codepipeline" "pipeline" {
  name          = "${var.project}-pipeline-${var.environment}"
  role_arn      = var.codepipeline_role
  pipeline_type = var.pipeline_type

  artifact_store {
    location = aws_s3_bucket.artifact_store.id
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.connection_arn
        FullRepositoryId = "${var.github_owner}/${var.repository}"
        BranchName       = var.github_branch
        DetectChanges    = "true"
      }
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
        BucketName = var.bucket_name_website
        Extract    = "true"
      }
    }
  }
}

resource "aws_s3_bucket" "hosting_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "hosting_bucket_controls" {
  bucket = aws_s3_bucket.hosting_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "hosting_bucket_block" {
  bucket = aws_s3_bucket.hosting_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "hosting_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.hosting_bucket_controls,
    aws_s3_bucket_public_access_block.hosting_bucket_block,
  ]
  bucket = aws_s3_bucket.hosting_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "hosting_bucket_policy" {
  bucket = aws_s3_bucket.hosting_bucket.id
  policy = data.aws_iam_policy_document.hosting_bucket_policy.json
}

data "aws_iam_policy_document" "hosting_bucket_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:*",
    
    ]

    resources = [
      aws_s3_bucket.hosting_bucket.arn,
      "${aws_s3_bucket.hosting_bucket.arn}/*",
    ]
  }
}

resource "aws_s3_bucket" "hosting_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_website_configuration" "hosting_bucket_configuration" {
  bucket = aws_s3_bucket.hosting_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_versioning" "hosting_bucket_versioning" {
  bucket = aws_s3_bucket.hosting_bucket.id
  versioning_configuration {
    status = "Enabled"
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
  acl    = "public-read"
}
resource "aws_s3_bucket_ownership_controls" "hosting_bucket_controls" {
  bucket = aws_s3_bucket.hosting_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_policy" "hosting_bucket_policy" {
  bucket = aws_s3_bucket.hosting_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.hosting_bucket.arn}/*"
        ]
      }
    ]
  })
}





# s3 static website url

output "website_url" {
  value = "http://${aws_s3_bucket.hosting_bucket.bucket}.s3-website-${var.aws_region}.amazonaws.com"
}
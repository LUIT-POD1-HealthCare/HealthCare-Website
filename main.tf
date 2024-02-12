resource "aws_s3_bucket" "hosting_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }


}

resource "aws_s3_bucket_acel" "hosting_bucket_acl" {
    bucket = aws_s3_bucket.hosting_bucket.id
    acl = "public-read"
}
   
resource "aws_s3_bucket_policy" "hosting_bucket_policy" {
    bucket =aws_s3_bucket.hosting_bucket.id

    policy = jsonencode(
        "Version": "2012-10-17",
        "Statement": [
            {
                    "Sid": "AllowPublicAccesstoObjects",
                    "Effect": "Allow",
                    "Principal": "*",
                    "Action": "s3:GetObject",
                    "Resource": "arn:aws:s3:::${var.bucket_name}/*"
            }
    ]


    )
}
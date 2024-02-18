output "website_bucket_dev_url" {
  description = "URL of the dev website bucket"
  value       = data.aws_s3_bucket.website_bucket_dev.website_endpoint
}

output "website_bucket_prod_url" {
  description = "URL of the prod website bucket"
  value       = data.aws_s3_bucket.website_bucket_prod.website_endpoint
}
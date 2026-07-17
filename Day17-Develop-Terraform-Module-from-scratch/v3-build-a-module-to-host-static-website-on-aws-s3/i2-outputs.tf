# Output variable definitions
output "name" {
  description = "Name (id) of the bucket"
  value       = module.mywebsite_s3_bucket.name
}

output "arn" {
  description = "ARN of the S3 Bucket"
  value       = module.mywebsite_s3_bucket.arn
}

output "bucket_domain_name" {
  description = "Bucket Domain Name of the S3 Bucket"
  value       = module.mywebsite_s3_bucket.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "Regional Domain Name of the S3 Bucket"
  value       = module.mywebsite_s3_bucket.bucket_regional_domain_name
}



# Static Website URL
output "static_website_url" {
  value = module.mywebsite_s3_bucket.static_website_url
}
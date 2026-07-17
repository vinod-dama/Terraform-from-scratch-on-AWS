module "mywebsite_s3_bucket" {
  source = "./modules/aws_s3"
  bucket_name = "my-static-website-${random_string.bucket_name.id}"
  #bucket_name = var.bucket_name
  tags = var.tags
}



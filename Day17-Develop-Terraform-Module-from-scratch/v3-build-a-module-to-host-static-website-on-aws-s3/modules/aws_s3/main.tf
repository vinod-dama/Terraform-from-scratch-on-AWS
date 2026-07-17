resource "aws_s3_bucket" "my_static_website" {
  #bucket = "mybucket-${random_pet.pet_name.id}"
  bucket = var.bucket_name
  force_destroy = true

  tags = {
    Name    = "My website bucket"
    LOB     = var.LOB
  }
}

#Resource-2: aws_s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "my_static_website" {
  bucket = aws_s3_bucket.my_static_website.id
  

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}


# Resource-3: aws_s3_bucket_versioning
resource "aws_s3_bucket_versioning" "my_static_website" {
  bucket =  aws_s3_bucket.my_static_website.id
  versioning_configuration {
    status = "Enabled"
  }
}


# Resource-4: aws_s3_bucket_ownership_controls
resource "aws_s3_bucket_ownership_controls" "my_static_website" {
  bucket = aws_s3_bucket.my_static_website.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Resource-5: aws_s3_bucket_public_access_block
resource "aws_s3_bucket_public_access_block" "my_static_website" {
  bucket = aws_s3_bucket.my_static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Resource-6: aws_s3_bucket_acl
resource "aws_s3_bucket_acl" "my_static_website" {
  depends_on = [
    aws_s3_bucket_ownership_controls.my_static_website,
    aws_s3_bucket_public_access_block.my_static_website
  ]
  bucket = aws_s3_bucket.my_static_website.id
  acl    = "public-read"
}

# Resource-7: aws_s3_bucket_policy
resource "aws_s3_bucket_policy" "my_static_website" {
  depends_on = [
    aws_s3_bucket_public_access_block.my_static_website
  ]
  bucket = aws_s3_bucket.my_static_website.id

  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "Statement1",
			"Principal": "*",
			"Effect": "Allow",
			"Action": [
				"s3:GetObject"
			],
			"Resource": [
				"arn:aws:s3:::${aws_s3_bucket.my_static_website.bucket}/*"
			]
		},
		{
			"Sid": "Statement2",
			"Principal": "*",
			"Effect": "Allow",
			"Action": [
			    "s3:PutBucketPolicy"
			 ],
			"Resource": [
			    "arn:aws:s3:::${aws_s3_bucket.my_static_website.bucket}"
	        ]
		}
	]
}
EOF
}

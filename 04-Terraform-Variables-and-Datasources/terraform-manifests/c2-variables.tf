# Input Variables
# AWS Region
variable "awsregion" {
  description = "region of aws instance where the ec2 instance needs to be created"
  type = string
  default = "us-east-1"
  
}

# AWS EC2 Instance Type
variable "instance_type" {
  description = "type of ec2 instance"
  type = string
  default = "t3.micro"  
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "key pair that needs to be authorized "
  type = string
  default = "terraform-key"
}

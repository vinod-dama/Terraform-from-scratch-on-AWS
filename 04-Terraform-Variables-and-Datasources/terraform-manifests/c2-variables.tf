# Input Variables
# AWS Region 

variable "region" {
  description = "Region of AWS to provision the resources"
  default = "ap-south-1"
  type = string
  
}

# AWS EC2 Instance Type
variable "instace_type" {
  description = "Type of EC2 to be provisioned"
  default = "t3.micro"
  type = string
}

# AWS EC2 Instance Key Pair
variable "key_name" {
  description = "key pair to conenct to EC2"
  default = "ap-south-1-keypair-new"
  type = string
}
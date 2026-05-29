# Input Variables
# AWS Region
variable "region" {
  description = "Region in which AWS Resources to be created"
  default = "ap-south-1"
  type = string
}

# AWS EC2 Instance Type
variable "instance_type" {
    description = "Region in which AWS Resources to be created"
    default = "t3.micro"
    type = string

}

# AWS EC2 Instance Key Pair
variable "key_name" {
    description = "AWS EC2 Key Pair that need to be associated with EC2 Instance"
    default = "ap-south-1-keypair-new"
    type = string
}   

# AWS EC2 Instance using list of strings
variable "instance_type_list" {
    description = "list of ec2 instances"
    default = ["t3.micro", "t3.small",  "c7i-flex.large"]
    type = list(string)
}

# AWS EC2 Instance using map of strings
variable "instance_type_map" {
    description = "map of ec2 instance"
    default = {
        "dev" = "t3.micro",
        "qa" = "t3.small",
        "prod" = "c7i-flex.large"
    }  
    type = map(string)
}
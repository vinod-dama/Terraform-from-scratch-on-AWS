variable "region" {
  description = "aws region for resource"
  default = "ap-south-1"
  type = string
}

variable "instance_type" {
    description = "ec2 instance type"
    default = "t3.micro"
    type = string

}


variable "key_name" {
    description = "key pair to connect to ec2"
    default = "ap-south-1-keypair-new"
    type = string
}   

variable "instance_type_list" {
    description = "list of ec2 instances"
    default = ["t3.micro", "t3.small",  "c7i-flex.large"]
    type = list(string)
}

variable "instance_type_map" {
    description = "map of ec2 instance"
    default = {
        "dev" = "t3.micro",
        "qa" = "t3.small",
        "prod" = "c7i-flex.large"
    }  
}
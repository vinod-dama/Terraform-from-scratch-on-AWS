# Input Variables
# AWS Region 

variable "region" {
  description = "Region of AWS to provision the resources"
  default = "us-west-2"
  #default = "ap-south-1"
  type = string
  
}

variable "LOB" {
  type = string
  default = "AI"
  
}

variable "department" {
  type = string
  default = "devops"
  
}


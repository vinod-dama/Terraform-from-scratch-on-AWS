# Input Variables
# AWS Region 

variable "region" {
  description = "Region of AWS to provision the resources"
  default = "ap-south-1"
  type = string
  
}

variable "department" {
  description = "department"
  default = "AI"
  type = string
  
}

variable "LOB" {
  description = "LOB"
  default = "Tech"
  type = string
  
}

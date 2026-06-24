# Input Variables
# AWS Region 

variable "region" {
  description = "Region of AWS to provision the resources"
  default     = "us-west-2"
  #default    = "ap-south-1"
  type        = string
  
}

variable "LOB" {
  description = "Line of Business"
  type        = string
  default     = "AI"
  
}

variable "department" {
  description = "Department of the resource belonging"
  type        = string
  default     = "devops"
  
}


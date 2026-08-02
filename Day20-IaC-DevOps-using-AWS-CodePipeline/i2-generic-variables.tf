# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"  
}
# Environment Variable
variable "LOB" {
  description = "LOB Variable used as a prefix"
  type = string
  default = "AI"
}
# Business Division
variable "department" {
  description = "department Division in the large organization this Infrastructure belongs"
  type = string
  default = "DevOps"
}
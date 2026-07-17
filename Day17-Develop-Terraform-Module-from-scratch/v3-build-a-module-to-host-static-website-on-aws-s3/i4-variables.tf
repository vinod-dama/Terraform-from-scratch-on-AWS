variable "region" {
    default = "ap-south-1"
  
}

variable "LOB" {
    default = "AIOPS"
  
}

variable "bucket_name" {
    default = "my-static-website-aiops-devops"
  
}

variable "tags" {
  description = "Tages to set on the bucket"
  type        = map(string)
  default     = {}
}


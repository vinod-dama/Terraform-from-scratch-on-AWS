variable "region" {
    default = "ap-south-1"
  
}

variable "LOB" {
    default = "AIOPS"
  
}


variable "tags" {
  description = "Tages to set on the bucket"
  type        = map(string)
  default     = {}
}


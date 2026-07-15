# AWS EC2 Security Group Terraform Variables
## Placeholder file for Variables
variable "db_username" {
  default   = "dbadmin"
  type      = string
  sensitive = true
}

variable "db_password" {
  default   = "dbpassword11"
  type      = string
  sensitive = true
}

variable "db_instance_reference" {
  type    = string
  default = "rds-db-instance"
}
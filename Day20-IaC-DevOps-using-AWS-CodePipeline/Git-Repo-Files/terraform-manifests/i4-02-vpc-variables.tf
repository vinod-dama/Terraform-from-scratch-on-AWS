# VPC Input Variables

# VPC Availability Zones
variable "azs" {
  default = ["ap-south-1a", "ap-south-1b"]
  type    = list(string)

}

# VPC Private Subnets
variable "vpc_private_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
  type    = list(string)
}

# VPC Public Subnets
variable "vpc_public_subnets" {
  default = ["10.0.11.0/24", "10.0.12.0/24"]
  type    = list(string)
}

# VPC Database Subnets 
variable "vpc_db_subnets" {
  default = ["10.0.21.0/24", "10.0.22.0/24"]
  type    = list(string)
}

# VPC CIDR Block
variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type    = string
}

variable "enable_nat_gateway" {
   default  = true
   type     = bool
}

variable "single_nat_gateway" {
   default  = true
   type     = bool
}

variable "one_nat_gateway_per_az" {
   default  = true
   type     = bool
}

variable "create_database_subnet_group" {
   default  = true
   type     = bool
}


variable "create_database_subnet_route_table" {
   default  = true
   type     = bool
}



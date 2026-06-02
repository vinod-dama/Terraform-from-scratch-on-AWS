# Create VPC Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.1"

  # VPC Basic Details
  name = "vpc-dev"
  cidr = "10.0.0.0/16"   
  azs                 = ["ap-south-1a", "ap-south-1b"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets      = ["10.0.11.0/24", "10.0.12.0/24"]

  # Database Subnets
  create_database_subnet_group = true
  database_subnets    = ["10.0.21.0/24", "10.0.22.0/24"]


  # NAT Gateways - Outbound Communication
  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support = true

  public_subnet_tags = {
    Type = "public-subnets"
  }

  private_subnet_tags = {
    Type = "private-subnets"
  }

  database_subnet_tags = {
    Type = "database-subnets"
  }

  tags = {
    department = "AI"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-dev"
  }
}



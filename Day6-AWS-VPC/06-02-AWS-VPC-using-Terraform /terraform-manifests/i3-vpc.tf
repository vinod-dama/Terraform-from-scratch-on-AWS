#VPC Module Block
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.1"

  name = "myvpc"
  cidr = "10.0.0.0/16"

  azs                    = ["ap-south-1a", "ap-south-1b"]
  private_subnets        = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets         = ["10.0.11.0/24", "10.0.12.0/24"]
  database_subnets       = ["10.0.21.0/24", "10.0.22.0/24"]

  # NAT Gateways - Outbound Communication
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  # DB Gateways - Outbound Communication
  create_database_subnet_group       = true
  create_database_subnet_route_table = true
  create_database_nat_gateway_route  = false
  
   # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  

 # Additional Tags to Subnets
  private_subnet_tags = {
    type = "private_subnet"
  }

  public_subnet_tags = {
    type = "public_subnet"
  }

  database_subnet_tags = {
    type = "database_subnet"
  }

  tags = {
    env = "dev"
  }

  vpc_tags = {
    name = "my-vpc"
  }
}

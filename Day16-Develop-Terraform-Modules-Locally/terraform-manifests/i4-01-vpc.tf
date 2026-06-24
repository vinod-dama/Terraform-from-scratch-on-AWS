#VPC Module Block
module "vpc" {
  source           = "./modules/terraform-aws-vpc-master"

  name             = "${local.name}-myvpc"
  cidr             = var.vpc_cidr

  azs              = var.azs
  private_subnets  = var.vpc_private_subnets
  public_subnets   = var.vpc_public_subnets
  database_subnets = var.vpc_db_subnets

  # NAT Gateways - Outbound Communication
  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

  #create_database_subnet_group = true
  #create_database_subnet_route_table= true
  
   # VPC DNS Parameters
  enable_dns_hostnames              = true
  enable_dns_support                = true

  create_database_nat_gateway_route = false

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

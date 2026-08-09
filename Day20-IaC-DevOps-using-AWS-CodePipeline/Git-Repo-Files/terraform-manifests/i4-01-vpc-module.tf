module "vpc" {
   source  = "terraform-aws-modules/vpc/aws"
    version = "6.6.1"
    name = "${local.name}-vpc"
    cidr = var.vpc_cidr

    azs                 = var.azs
    
    private_subnets     = var.vpc_private_subnets
    public_subnets      = var.vpc_public_subnets
    database_subnets    = var.vpc_db_subnets
 
    
    manage_default_network_acl    = false
    manage_default_route_table    = false
    manage_default_security_group = false

    create_database_subnet_group       = var.create_database_subnet_group
    create_database_subnet_route_table = var.create_database_subnet_route_table

    # VPC DNS Parameters
    enable_dns_hostnames = true
    enable_dns_support   = true

    # NAT Gateways - Outbound Communication
    enable_nat_gateway     = var.enable_nat_gateway
    single_nat_gateway     = var.single_nat_gateway
    one_nat_gateway_per_az = var.one_nat_gateway_per_az

    enable_vpn_gateway = true

    # Additional Tags to Subnets
    public_subnet_tags = {
        Type = "Public Subnets"
    }
    private_subnet_tags = {
        Type = "Private Subnets"
    }  
    database_subnet_tags = {
        Type = "Private Database Subnets"
    }

    tags = local.common_tags
}
module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  name        = "private-sg-${local.name}"
  description = "Private security group "
  vpc_id      = module.vpc.vpc_id

  ingress_rules = {
    https-from-vpc = {
      from_port   = 8080
      to_port     = 8080
      ip_protocol = "tcp"
      cidr_ipv4   = var.vpc_cidr
      description = "HTTPS from VPC"
    }

    http-from-vpc = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = var.vpc_cidr
      description = "HTTP from IPv4"
    }

    ssh-from-vpc = {
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      cidr_ipv4   = var.vpc_cidr
      description = "SSH from IPv4"
    }

  }

  egress_rules = {
    internal = {
      ip_protocol = "-1"
      cidr_ipv4   = var.vpc_cidr
      description = "Internal VPC traffic"
    }

    https-internet = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
      description = "HTTPS through NAT Gateway"
    }
  }


  tags = local.common_tags
}

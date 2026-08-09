module "lb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  name        = "lb-sg-${local.name}"
  description = "LoadBalancer security group "
  vpc_id      = module.vpc.vpc_id

  ingress_rules = {
    https-from-vpc = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
      description = "HTTPS from VPC"
    }

    http-from-vpc = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
      description = "HTTP from IPv4"
    }

  }

  egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
      description = "All outbound"
    }
  }

  tags = local.common_tags
}






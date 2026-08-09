module "bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  name        = "bastion-sg-${local.name}"
  description = "Public security group "
  vpc_id      = module.vpc.vpc_id

  ingress_rules = {
    ssh-from-vpc = {
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
      description = "SSH from IPv4"
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

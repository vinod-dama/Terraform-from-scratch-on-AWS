# AWS EC2 Security Group Terraform Module
# Security Group for Public Bastion Host
module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"

  name = "private-sg"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["http-80-tcp", "ssh-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags 
}
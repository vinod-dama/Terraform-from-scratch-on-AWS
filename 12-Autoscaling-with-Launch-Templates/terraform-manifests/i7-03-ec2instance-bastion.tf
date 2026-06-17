
module "bastion_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.4.0"
  name = "bastion-instance"

  ami = data.aws_ami.ami_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  

  tags = local.common_tags
}
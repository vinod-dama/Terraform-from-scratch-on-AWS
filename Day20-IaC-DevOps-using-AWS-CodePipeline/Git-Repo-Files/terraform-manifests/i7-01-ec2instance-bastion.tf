module "bastion_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.4.0"

  name          = "bastion-ec2-instance"
  ami           = data.aws_ami.ami_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name
  #monitoring   = true
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.bastion_sg.id]


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
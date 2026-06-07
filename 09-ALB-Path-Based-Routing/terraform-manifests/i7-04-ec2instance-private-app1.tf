
module "ec2_private_app1" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.4.0"
  name = "private-instance-app1"

  ami = data.aws_ami.ami_id.id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = module.private_sg.security_group_id
  user_data = file("${path.module}/app1-install.sh")

  for_each = toset(["0", "1"])
  subnet_id = elements([module.vpc.private_subnets, tonumber(each.key)])

  tags = local.common_tags
}
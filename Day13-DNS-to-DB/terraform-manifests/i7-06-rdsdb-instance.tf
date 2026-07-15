
module "rds_db_instnace" {
  depends_on = [module.vpc]
  source     = "terraform-aws-modules/ec2-instance/aws"
  version    = "6.4.0"
  name       = "rds_db"

  ami                         = data.aws_ami.ami_linux.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [module.private_sg.security_group_id]
  user_data                   = file("${path.module}/app3-ums-install.sh")
  user_data_replace_on_change = true

  for_each  = toset(["0", "1"])
  subnet_id = element(module.vpc.private_subnets, tonumber(each.key))
  #subnet_id = module.vpc.private_subnets[0]

  tags = local.common_tags
}
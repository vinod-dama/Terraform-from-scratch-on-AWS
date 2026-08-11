resource "aws_eip" "elasticip" {
    depends_on = [module.vpc, module.bastion_ec2_instance]
    instance   = module.bastion_ec2_instance.id
    domain     = "vpc"
    tags       = local.common_tags
}
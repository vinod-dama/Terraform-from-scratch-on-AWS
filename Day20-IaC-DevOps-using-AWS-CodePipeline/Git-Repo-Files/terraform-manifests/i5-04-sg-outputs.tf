################################################################################
# Bastion Security Group
################################################################################

output "bastion_sg_arn" {
  description = "The ARN of the security group"
  value       = module.bastion_sg.arn
}

output "bastion_sg_id" {
  description = "The ID of the security group"
  value       = module.bastion_sg.id
}

output "bastion_sg_name" {
  description = "The name of the security group"
  value       = module.bastion_sg.name
}


output "bastion_sg_vpc_id" {
  description = "The VPC ID of the security group"
  value       = module.bastion_sg.vpc_id
}



################################################################################
# Private Security Group
################################################################################

output "private_sg_arn" {
  description = "The ARN of the security group"
  value       = module.private_sg.arn
}

output "private_sg_id" {
  description = "The ID of the security group"
  value       = module.private_sg.id
}

output "private_sg_name" {
  description = "The name of the security group"
  value       = module.private_sg.name
}

output "private_sg_vpc_id" {
  description = "The VPC ID of the security group"
  value       = module.private_sg.vpc_id
}


################################################################################
# Load Balancer Security Group
################################################################################

output "lb_sg_arn" {
  description = "The ARN of the security group"
  value       = module.lb_sg.arn
}

output "lb_sg_id" {
  description = "The ID of the security group"
  value       = module.lb_sg.id
}

output "lb_sg_name" {
  description = "The name of the security group"
  value       = module.lb_sg.name
}

output "lb_sg_vpc_id" {
  description = "The VPC ID of the security group"
  value       = module.lb_sg.vpc_id
}
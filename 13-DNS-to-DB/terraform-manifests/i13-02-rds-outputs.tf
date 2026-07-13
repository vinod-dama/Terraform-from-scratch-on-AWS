/*
output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.rds_db.db_instance_address
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = module.rds_db.db_instance_arn
}
*/


output "rds_secret_arn" {
  value = module.rds_db.db_instance_master_user_secret_arn
}
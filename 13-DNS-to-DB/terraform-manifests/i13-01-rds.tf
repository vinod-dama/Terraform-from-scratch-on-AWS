################################################################################
# RDS Module
################################################################################

module "rds_db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "7.2.0"

  identifier = var.db_instance_reference

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine               = "mysql"
  engine_version       = "8.0"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = "db.t4g.large"

  allocated_storage     = 20
  max_allocated_storage = 100

  db_name                     = var.db_instance_reference
  username                    = var.db_username
  manage_master_user_password = false
  password_wo                 = var.db_password
  password_wo_version         = 1
  port                        = "3306"

  multi_az = true

  subnet_ids = module.vpc.private_subnets


  db_subnet_group_name   = module.vpc.database_subnet_group_name
  vpc_security_group_ids = [module.rdsdb_sg.security_group_id]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["general"]
  create_cloudwatch_log_group     = true

  skip_final_snapshot = true
  deletion_protection = false

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  tags = local.common_tags
  db_instance_tags = {
    "Sensitive" = "high"
  }
  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }
  db_subnet_group_tags = {
    "Sensitive" = "high"
  }
  cloudwatch_log_group_tags = {
    "Sensitive" = "high"
  }
}


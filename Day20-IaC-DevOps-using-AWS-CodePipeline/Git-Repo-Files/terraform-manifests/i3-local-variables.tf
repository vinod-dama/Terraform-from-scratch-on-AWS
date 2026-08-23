# Define Local Values in Terraform
locals {
  department = var.department
  LOB        = var.LOB
  name       = "${var.department}-${var.LOB}"

  common_tags = {
    owners      = local.LOB
    environment = local.department

  }
}
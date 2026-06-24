# Define Local Values in Terraform
locals {
    department  = var.department
    lob         = var.LOB
    name        = "${var.department}-${var.LOB}"

    common_tags = {
        owners      = local.department
        environment = local.lob
    }
}
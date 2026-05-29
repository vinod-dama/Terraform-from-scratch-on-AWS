# Terraform Block
terraform {
  required_version = ">= 1.15.4"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.92"
    }
  }
}

# Provider Block
provider "aws" {
    region = var.region
    profile = "default"
}


/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/
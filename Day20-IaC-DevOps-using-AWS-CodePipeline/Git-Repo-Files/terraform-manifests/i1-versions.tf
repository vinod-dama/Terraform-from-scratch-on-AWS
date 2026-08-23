# Terraform Block
terraform {
  required_version = "~> 1.15.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
  }
  backend "s3" {
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "default"

}


# Create Random Pet Resource
resource "random_pet" "this" {
  length = 4
}


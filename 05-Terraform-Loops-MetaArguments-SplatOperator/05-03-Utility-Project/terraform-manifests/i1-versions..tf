terraform {
  required_version = ">= 1.15.4"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.92"
    }
  }
}

provider "aws" {
    region = "us-east-1"
    profile = "default"
}
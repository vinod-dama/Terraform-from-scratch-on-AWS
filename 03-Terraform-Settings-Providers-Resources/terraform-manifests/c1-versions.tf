# Terraform Block
terraform {
  required_version = "~> 1.4"
  required_providers {
     aws = {
        source = "hashicorp/aws"
        version = "5.38.0"
  }
 }
}
# Provider Block
provider "aws" {
  region = "us-east-1"
}

/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials

else if you need to use a different profile, follow below
provider "aws" {
  region = "us-east-1"
  profile = "<profilename>" #profilename to be picked from $HOME/.aws/credentials file 
}
*/


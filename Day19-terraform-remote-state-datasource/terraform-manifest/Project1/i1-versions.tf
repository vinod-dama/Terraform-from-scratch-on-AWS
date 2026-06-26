# Terraform Block
terraform {
  required_version = "~> 1.15.4"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }


  backend "s3" {
    bucket = "mybucket-aiops-devops-bucket"
    key = "project1/dev"
    region = "ap-south-1"

    #dynamodb_table = "project1-dev-vpc"
    use_lockfile = true

  }
}

provider "aws" {
    region = var.region
    profile = "default"

}


# Create Random Pet Resource
resource "random_pet" "pet_name" {
    length = 3
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


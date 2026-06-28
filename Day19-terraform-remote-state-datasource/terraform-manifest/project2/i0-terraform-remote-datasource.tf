data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "mybucket-aiops-devops-bucket"
    key    = "project1/dev"
    region = "ap-south-1"

    #dynamodb_table = "project1-dev-vpc"
    use_lockfile = true
  }
}
data "aws_instances" "amz-linux" {
    most_recent = true
    owners = ["amazon"]

    filter {
        name = "ami"
        values = ["al2023-ami-2023.*"]
    }

    filter {
        name = "root-device-type"
        values = ["ebs"]
    }
  
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}


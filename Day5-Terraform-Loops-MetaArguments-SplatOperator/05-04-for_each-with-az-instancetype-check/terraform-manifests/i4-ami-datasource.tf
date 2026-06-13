data "aws_ami" "ami_id" {
    most_recent = true
    owners = ["amazon"]

    filter {
      name = "architecture"
      values = [ "x86_64" ]
    }

    
    filter {
      name = "virtualization-type"
      values = [ "hvm" ]
    }    
    
    filter {
      name = "root-device-type"
      values = ["ebs"]
    }
    
    filter {
    name = "name"
    values = ["al2023-ami-*"]
    }
}
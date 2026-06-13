# Get latest AMI ID for Amazon Linux OS
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
    values = ["al2023-ami-*"] # Fetch latest AMI dynamically using AWS AMI naming convention (change pattern for different OS flavors)
}
}

/*
AWS Console walkthrough to identify AMI name pattern:
EC2 Console → Launch Instance → Search desired OS AMI →
Copy AMI Name format (e.g., amzn2-ami-hvm-*-gp2) →
Use wildcard (*) for changing version/date portion →
Apply in aws_ami filter with most_recent=true to always fetch latest AMI ID
*/
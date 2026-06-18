# Resource: EC2 Instance

resource "aws_instance" "myec2_vm" {
  ami           = "ami-09ed39e30153c3bf9"
  instance_type = "t3.micro"
  user_data     = file("${path.module}/app1-install.sh")
  tags = {
    "Name"      = " EC2 Sample demo"
  }
}

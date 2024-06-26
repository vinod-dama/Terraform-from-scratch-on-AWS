# Resource: EC2 Instance

resource "aws_instance" "myec2-vm" {
  ami = "ami-0440d3b780d96b29d"
  instance_type = "t3.micro"
  user_data = file("${path.module}/app1-install.sh")
  tags = {
    "Name" = " EC2 Sample demo"
  }
}

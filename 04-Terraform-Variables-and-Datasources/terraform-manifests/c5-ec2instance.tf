# EC2 Instance
resource "aws_instance" "myec2_vm" {
  ami = data.aws_ami.amzn_ami.id
  instance_type = var.instace_type
  key_name = var.key_name
  user_data = file("${path.module}/app1-install.sh")
  vpc_security_group_ids = [ aws_security_group.vpc_ssh.id, aws_security_group.vpc_web.id   ]
  tags = {
    "Name" = "Dynamic-ami-ec2" 
  }
}
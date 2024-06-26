# Create Security Group - SSH Traffic
resource "aws_security_group" "vpc_ssh" {
  name = "vpc_ssh"
  description = "ec2 vpc ssh connection establishment"
  ingress {
    description = "allow port 80"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }  
  egress {
    description = "allow all ip and outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0"]
  }
  tags = {
   Name = "vpc_ssh"
  }
}

 #Create Security Group - web Traffic

 resource "aws_security_group" "vpc_web" {
  description = " allow traffic for vpc web"
  name = "vpc_web"
  tags = {
    Name = "vpc_web"
  }
   ingress {
    description = "allow ingress on vpc web"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0"]
   }
   ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
   }
   egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0"]
   }
}



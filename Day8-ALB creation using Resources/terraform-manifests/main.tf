resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"

}

resource "aws_subnet" "pub_sub1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"
  tags = {
    Name = "public-subnet1"
  }
}

resource "aws_subnet" "pub_sub2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1b"
  tags = {
    Name = "public-subnet2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
  
  tags = {
    Name = "igw-main"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "rt-association-1" {
  subnet_id      = aws_subnet.pub_sub1.id
  route_table_id = aws_route_table.rt.id
}



resource "aws_route_table_association" "rt-association-2" {
  subnet_id      = aws_subnet.pub_sub2.id
  route_table_id = aws_route_table.rt.id
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2-allow_tls_ipv4-1" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "ec2-allow_tls_ipv4-2" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


resource "aws_security_group" "lb_sg" {
  name        = "lb-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "lb_allow_tls_ipv4" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "lb_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# Get latest AMI ID for Amazon Linux OS
data "aws_ami" "ami_linux" {
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


resource "aws_instance" "ec2-1" {
  ami = data.aws_ami.ami_linux.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.pub_sub1.id
  key_name = "south-keypai-21052026"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = base64encode(file("${path.module}/app1-install.sh"))
}



resource "aws_instance" "ec2-2" {
  ami = data.aws_ami.ami_linux.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.pub_sub2.id
  key_name = "south-keypai-21052026"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = base64encode(file("${path.module}/app2-install.sh"))
}



resource "aws_lb" "my_lb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.pub_sub1.id, aws_subnet.pub_sub2.id]

  enable_deletion_protection = false

  tags = {
    Environment = "Dev"
  }
}

resource "aws_lb_target_group" "my_lb_tg" {
  name     = "my-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }

}

resource "aws_lb_target_group_attachment" "ec2-instance1-tga" {
  target_group_arn = aws_lb_target_group.my_lb_tg.arn
  target_id        = aws_instance.ec2-1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "ec2-instance2-tga" {
  target_group_arn = aws_lb_target_group.my_lb_tg.arn
  target_id        = aws_instance.ec2-2.id
  port             = 80
}



resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_lb_tg.arn
  }
}


resource "aws_s3_bucket" "lb_logs" {
  bucket = "my-tf-test-bucket-2026-vinod"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

output "loadbalancerdns" {
  value = aws_lb.my_lb.dns_name
}



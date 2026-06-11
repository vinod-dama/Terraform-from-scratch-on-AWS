resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"

}

resource "aws_subnet" "pub_sub1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "public-subnet1"
  }
}

resource "aws_subnet" "pub_sub2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
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




/*
resource "aws_instance" "ec2_!" {
  ami = "ami-0152204c1a187337c"
  instance_type = "t3.micro"
  subnet_id = ["aws_subnet.pub_sub2.id", "aws_subnet.pub_sub1.id"]
  tags = {
    Name = "test-spot"
  }
}
*/
resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.15.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my vpc"
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.15.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "my_public_subnet"
  }
}
resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.15.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "my_public_subnet2"
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.15.12.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "my_private_subnet"
  }
}
resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.15.14.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "my_private_subnet2"
  }
}
resource "aws_route_table" "my_public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "my public route table"
  }
}
resource "aws_route_table" "my_private_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "my private route table"
  }
}
resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.my_public_rt.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my internet gateway"
  }
}
resource "aws_route_table_association" "private_rt_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.my_private_rt.id
}
resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "allow ssh connection"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "allow all ICMP"
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}
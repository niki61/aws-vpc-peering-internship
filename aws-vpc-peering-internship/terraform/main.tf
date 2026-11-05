terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# ==============================================================================
# VPC A (Requester) - 10.0.0.0/16
# ==============================================================================
resource "aws_vpc" "vpc_a" {
  cidr_block           = var.vpc_a_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name    = "VPC-A-Requester"
    Project = "AWS-Internship-Batch-1"
    Author  = "Avhishek"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.vpc_a.id
  cidr_block              = var.vpc_a_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-A-Public"
  }
}

resource "aws_internet_gateway" "igw_a" {
  vpc_id = aws_vpc.vpc_a.id

  tags = {
    Name = "IGW-VPC-A"
  }
}

resource "aws_route_table" "rt_a" {
  vpc_id = aws_vpc.vpc_a.id

  # Public Internet Route
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_a.id
  }

  # Peering Route towards VPC B
  route {
    cidr_block                = var.vpc_b_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.peering_conn.id
  }

  tags = {
    Name = "RouteTable-VPC-A"
  }
}

resource "aws_route_table_association" "rta_a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.rt_a.id
}

# ==============================================================================
# VPC B (Accepter) - 10.1.0.0/16
# ==============================================================================
resource "aws_vpc" "vpc_b" {
  cidr_block           = var.vpc_b_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name    = "VPC-B-Accepter"
    Project = "AWS-Internship-Batch-1"
    Author  = "Avhishek"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.vpc_b.id
  cidr_block              = var.vpc_b_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-B-Public"
  }
}

resource "aws_internet_gateway" "igw_b" {
  vpc_id = aws_vpc.vpc_b.id

  tags = {
    Name = "IGW-VPC-B"
  }
}

resource "aws_route_table" "rt_b" {
  vpc_id = aws_vpc.vpc_b.id

  # Public Internet Route
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_b.id
  }

  # Peering Route towards VPC A
  route {
    cidr_block                = var.vpc_a_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.peering_conn.id
  }

  tags = {
    Name = "RouteTable-VPC-B"
  }
}

resource "aws_route_table_association" "rta_b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.rt_b.id
}

# ==============================================================================
# VPC Peering Connection (VPC A <-> VPC B)
# ==============================================================================
resource "aws_vpc_peering_connection" "peering_conn" {
  peer_vpc_id = aws_vpc.vpc_b.id
  vpc_id      = aws_vpc.vpc_a.id
  auto_accept = true

  tags = {
    Name    = "VPC-Peering-A-to-B"
    Project = "AWS-Internship-Batch-1"
  }
}

# ==============================================================================
# Security Groups (SSH + Cross-VPC ICMP Ping)
# ==============================================================================
resource "aws_security_group" "sg_a" {
  name        = "SecurityGroup-Server-A"
  description = "Allow inbound SSH and ICMP ping from VPC B"
  vpc_id      = aws_vpc.vpc_a.id

  ingress {
    description = "SSH for management"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP Echo from VPC B"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc_b_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-Server-A"
  }
}

resource "aws_security_group" "sg_b" {
  name        = "SecurityGroup-Server-B"
  description = "Allow inbound SSH and ICMP ping from VPC A"
  vpc_id      = aws_vpc.vpc_b.id

  ingress {
    description = "SSH for management"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP Echo from VPC A"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc_a_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-Server-B"
  }
}

# ==============================================================================
# Test EC2 Instances (Free Tier eligible)
# ==============================================================================
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "server_a" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet_a.id
  vpc_security_group_ids      = [aws_security_group.sg_a.id]
  associate_public_ip_address = true

  tags = {
    Name    = "Server-A"
    VPC     = "VPC-A"
    Project = "AWS-Internship-Batch-1"
  }
}

resource "aws_instance" "server_b" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet_b.id
  vpc_security_group_ids      = [aws_security_group.sg_b.id]
  associate_public_ip_address = true

  tags = {
    Name    = "Server-B"
    VPC     = "VPC-B"
    Project = "AWS-Internship-Batch-1"
  }
}

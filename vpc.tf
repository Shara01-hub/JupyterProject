# This file conatins the VPC for cloudrainbowtester
resource "aws_vpc" "patty_moore_website_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "patty_moore_website_vpc"
  }
}

# This resource creates an Internet Gateway and attaches it to the VPC.
resource "aws_internet_gateway" "patty_moore_website_vpc_igw" {
  vpc_id = aws_vpc.patty_moore_website_vpc.id

  tags = {
    Name = "patty_moore_vpc"
  }
}

# This resource creates a public subnet AZ 1a in the VPC.
# Ensure you name the subnet to public_subnet-az1a to match the naming convention.
resource "aws_subnet" "patty_moore_website_public_subnet_az1a" {
  vpc_id                  = aws_vpc.patty_moore_website_vpc.id
  cidr_block              = var.public_subnet_az1a_cidr
  availability_zone       = "us-east-1a" # Change this to your desired availability zone
  map_public_ip_on_launch = true
  depends_on = [aws_vpc.patty_moore_website_vpc,
  aws_internet_gateway.patty_moore_website_vpc_igw]

  tags = {
    Name = "patty_moore_website_public_subnet-az1a"
  }
}

# This resource creates a public subnet AZ 1b in the VPC.
# Ensure you name the subnet to public_subnet-az1a to match the naming convention.
resource "aws_subnet" "patty_moore_website_public_subnet_az1b" {
  vpc_id                  = aws_vpc.patty_moore_website_vpc.id
  cidr_block              = var.public_subnet_az1b_cidr
  availability_zone       = "us-east-1b" # Change this to your desired availability zone
  map_public_ip_on_launch = true

  depends_on = [aws_vpc.patty_moore_website_vpc,
  aws_internet_gateway.patty_moore_website_vpc_igw]

  tags = {
    Name = "patty_moore_website_public_subnet-az1b"
  }
}

# This resource creates a private app subnet AZ 1a in the VPC.
# Ensure you name the subnet to private_app_subnet-az1a to match the naming convention.
resource "aws_subnet" "patty_moore_website_private_app_subnet_az1a" {
  vpc_id                  = aws_vpc.patty_moore_website_vpc.id
  cidr_block              = var.private_app_subnet_az1a_cidr
  availability_zone       = "us-east-1a" # Change this to your desired availability zone
  map_public_ip_on_launch = false

  depends_on = [aws_vpc.patty_moore_website_vpc,
  aws_internet_gateway.patty_moore_website_vpc_igw]

  tags = {
    Name = "patty_moore_website_private_app_subnet_az1a"
  }
}

# This resource creates a private app subnet AZ 1b in the VPC.
# Ensure you name the subnet to private_app_subnet-az1b to match the naming convention.
resource "aws_subnet" "patty_moore_website_private_app_subnet_az1b" {
  vpc_id                  = aws_vpc.patty_moore_website_vpc.id
  cidr_block              = var.private_app_subnet_az1b_cidr
  availability_zone       = "us-east-1b" # Change this to your desired availability zone
  map_public_ip_on_launch = false

  depends_on = [aws_vpc.patty_moore_website_vpc,
  aws_internet_gateway.patty_moore_website_vpc_igw]

  tags = {
    Name = "patty_moore_website_private_app_subnet_az1b"
  }
}

# This resource creates a private DB subnet AZ 1a in the VPC.
# Ensure you name the subnet to private_DB_subnet-az1a to match the naming convention.
resource "aws_subnet" "patty_moore_website_private_DB_subnet_az1a" {
  vpc_id                  = aws_vpc.patty_moore_website_vpc.id
  cidr_block              = var.private_DB_app_subnet_az1a_cidr
  availability_zone       = "us-east-1a" # Change this to your desired availability zone
  map_public_ip_on_launch = false

  depends_on = [aws_vpc.patty_moore_website_vpc,
  aws_internet_gateway.patty_moore_website_vpc_igw]

  tags = {
    Name = "patty_moore_website_private_DB_subnet-az1a"
  }
}

# This resource creates a private DB subnet AZ 1b in the VPC.
# Ensure you name the subnet to private_DB_subnet-az1b to match the naming convention.
resource "aws_subnet" "patty_moore_website_private_DB_subnet_az1b" {
  vpc_id                  = aws_vpc.patty_moore_website_vpc.id
  cidr_block              = var.private_DB_app_subnet_az1b_cidr
  availability_zone       = "us-east-1b" # Change this to your desired availability zone
  map_public_ip_on_launch = false

  depends_on = [aws_vpc.patty_moore_website_vpc,
  aws_internet_gateway.patty_moore_website_vpc_igw]

  tags = {
    Name = "patty_moore_website_private_DB_subnet-az1b"
  }
}

# To create EIP for NAT gateway in public subnet AZ1a. 
resource "aws_eip" "patty_moore_website_nat_gateway_eip_az1a" {
  domain = "vpc"

  tags = {
    Name = "patty_moore_website_EIP"
  }
}
# This is to create NAT gateway and attach an elastic IP in a public subnet.
resource "aws_nat_gateway" "patty_moore_website_nat_gateway_az1a" {
  allocation_id = aws_eip.patty_moore_website_nat_gateway_eip_az1a.id
  subnet_id     = aws_subnet.patty_moore_website_public_subnet_az1a.id

  tags = {
    Name = "patty_moore_website_nat_gateway_az1a"
  }

  depends_on = [
    aws_internet_gateway.patty_moore_website_vpc_igw,
    aws_subnet.patty_moore_website_public_subnet_az1a
  ]
}

#This a Public Route Table for the public subnets
resource "aws_route_table" "patty_moore_website_publicRT" {
  vpc_id = aws_vpc.patty_moore_website_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.patty_moore_website_vpc_igw.id
  }

  tags = {
    Name = "public subnet az1a RT"
  }
}

# To associate the public RT to the public subnets
resource "aws_route_table_association" "public_subnet_association_az1a" {
  subnet_id      = aws_subnet.patty_moore_website_public_subnet_az1a.id
  route_table_id = aws_route_table.patty_moore_website_publicRT.id
}

# associate the public route table with the public subnets in AZ 1b.
resource "aws_route_table_association" "public_subnet_association_az1b" {
  subnet_id      = aws_subnet.patty_moore_website_public_subnet_az1b.id
  route_table_id = aws_route_table.patty_moore_website_publicRT.id
}

# this is a Private Route Table for the private app subnets.
resource "aws_route_table" "patty_moore_website_private_app_RT" {
  vpc_id = aws_vpc.patty_moore_website_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.patty_moore_website_nat_gateway_az1a.id
  }
  tags = {
    Name = "Route Table for Private App Subnets"
  }
}


# this is a Private Route Table for the private database subnets.
resource "aws_route_table" "patty_moore_website_private_DB_RT" {
  vpc_id = aws_vpc.patty_moore_website_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.patty_moore_website_nat_gateway_az1a.id
  }
  tags = {
    Name = "Route Table for Private Database Subnets"
  }
}


# associate the private app route table with the private app subnets in AZ 1a
resource "aws_route_table_association" "private_app_subnet_association_az1a" {
  subnet_id      = aws_subnet.patty_moore_website_private_app_subnet_az1a.id
  route_table_id = aws_route_table.patty_moore_website_private_app_RT.id
}

# associate the private app route table with the private app subnets in AZ 1b
resource "aws_route_table_association" "private_app_subnet_association_az1b" {
  subnet_id      = aws_subnet.patty_moore_website_private_app_subnet_az1b.id
  route_table_id = aws_route_table.patty_moore_website_private_app_RT.id
}

# associate the private database route table with a private database subnet in AZ 1a
resource "aws_route_table_association" "private_db_subnet_association_az1a" {
  subnet_id      = aws_subnet.patty_moore_website_private_DB_subnet_az1a.id
  route_table_id = aws_route_table.patty_moore_website_private_DB_RT.id
}
# associate the private database route table with the private database subnet in AZ 1b
resource "aws_route_table_association" "private_db_subnet_association_az1b" {
  subnet_id      = aws_subnet.patty_moore_website_private_DB_subnet_az1b.id
  route_table_id = aws_route_table.patty_moore_website_private_DB_RT.id
}
  
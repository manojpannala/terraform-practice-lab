# Create AWS VPC
resource "aws_vpc" "mrp_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"

  tags = {
    Name = "mrp_vpc"
  }
}

# Create Pubic Subnet
resource "aws_subnet" "mrp_subnet_public-1" {
  vpc_id     = aws_vpc.mrp_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "mrp_subnet_public-1"
  }
}

# Create Public Subnet
resource "aws_subnet" "mrp_subnet_public-2" {
  vpc_id     = aws_vpc.mrp_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "mrp_subnet_public-2"
  }
}

# Create Public Subnet
resource "aws_subnet" "mrp_subnet_public-3" {
  vpc_id     = aws_vpc.mrp_vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "eu-central-1c"

  tags = {
    Name = "mrp_subnet_public-3"
  }
}

# Create Private Subnet
resource "aws_subnet" "mrp_subnet_private-1" {
  vpc_id     = aws_vpc.mrp_vpc.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "mrp_subnet_private-1"
  }
}

# Create Private Subnet
resource "aws_subnet" "mrp_subnet_private-2" {
  vpc_id     = aws_vpc.mrp_vpc.id
  cidr_block = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "mrp_subnet_private-2"
  }
}

# Create Private Subnet
resource "aws_subnet" "mrp_subnet_private-3" {
  vpc_id     = aws_vpc.mrp_vpc.id
  cidr_block = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "eu-central-1c"

  tags = {
    Name = "mrp_subnet_private-3"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "mrp-igw" {
  vpc_id = aws_vpc.mrp_vpc.id
  
  tags = {
    Name = "mrp-igw"
  }
}

# Create Route Table
resource "aws_route_table" "mrp-rtb" {
  vpc_id = aws_vpc.mrp_vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.mrp-igw.id
  }
  tags = {
     Name = "mrp-rtb-1"
  }
}

# Create Route Table Association
resource "aws_route_table_association" "mrp-rtb-1-a" {
  subnet_id = aws_subnet.mrp_subnet_public-1.id
  route_table_id = aws_route_table.mrp-rtb.id
}

# Create Route Table Association
resource "aws_route_table_association" "mrp-rtb-2-a" {
  subnet_id = aws_subnet.mrp_subnet_public-2.id
  route_table_id = aws_route_table.mrp-rtb.id
}

# Create Route Table Association
resource "aws_route_table_association" "mrp-rtb-3-a" {
  subnet_id = aws_subnet.mrp_subnet_public-3.id
  route_table_id = aws_route_table.mrp-rtb.id
}
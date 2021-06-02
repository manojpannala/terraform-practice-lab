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
#Create AWS VPC
resource "aws_vpc" "mrpvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "mrpvpc"
  }
}

# Public Subnets in Custom VPC
resource "aws_subnet" "mrpvpc-public-1" {
  vpc_id                  = aws_vpc.mrpvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-central-1a"

  tags = {
    Name = "mrpvpc-public-1"
  }
}

resource "aws_subnet" "mrpvpc-public-2" {
  vpc_id                  = aws_vpc.mrpvpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-central-1b"

  tags = {
    Name = "mrpvpc-public-2"
  }
}

resource "aws_subnet" "mrpvpc-public-3" {
  vpc_id                  = aws_vpc.mrpvpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-central-1c"

  tags = {
    Name = "mrpvpc-public-3"
  }
}

# Private Subnets in Custom VPC
resource "aws_subnet" "mrpvpc-private-1" {
  vpc_id                  = aws_vpc.mrpvpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-central-1a"

  tags = {
    Name = "mrpvpc-private-1"
  }
}

resource "aws_subnet" "mrpvpc-private-2" {
  vpc_id                  = aws_vpc.mrpvpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-central-1b"

  tags = {
    Name = "mrpvpc-private-2"
  }
}

resource "aws_subnet" "mrpvpc-private-3" {
  vpc_id                  = aws_vpc.mrpvpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-central-1c"

  tags = {
    Name = "mrpvpc-private-3"
  }
}

# Custom internet Gateway
resource "aws_internet_gateway" "mrp-gw" {
  vpc_id = aws_vpc.mrpvpc.id

  tags = {
    Name = "mrp-gw"
  }
}

#Routing Table for the Custom VPC
resource "aws_route_table" "mrp-public" {
  vpc_id = aws_vpc.mrpvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mrp-gw.id
  }

  tags = {
    Name = "mrp-public-1"
  }
}

resource "aws_route_table_association" "mrp-public-1-a" {
  subnet_id      = aws_subnet.mrpvpc-public-1.id
  route_table_id = aws_route_table.mrp-public.id
}

resource "aws_route_table_association" "mrp-public-2-a" {
  subnet_id      = aws_subnet.mrpvpc-public-2.id
  route_table_id = aws_route_table.mrp-public.id
}

resource "aws_route_table_association" "mrp-public-3-a" {
  subnet_id      = aws_subnet.mrpvpc-public-3.id
  route_table_id = aws_route_table.mrp-public.id
}

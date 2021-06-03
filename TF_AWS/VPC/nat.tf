# Define External IP
resource "aws_eip" "mrp-nat" {
  vpc = true
}

resource "aws_nat_gateway" "mrp-nat-gw" {
  allocation_id = aws_eip.mrp-nat.id
  subnet_id = aws_subnet.mrp_subnet_public-1.id
  depends_on = [
    aws_internet_gateway.mrp-igw
  ]
}

resource "aws_route_table" "mrp-private" {
  vpc_id = aws_vpc.mrp_vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.mrp-nat-gw.id
  }
  tags = {
    Name = "mrp-private"
  }
}

# route associations private

resource "aws_route_table_association" "mrp_nat_private-1-a" {
  subnet_id = aws_subnet.mrp_subnet_private-1.id
  route_table_id = aws_route_table.mrp-private.id
}

resource "aws_route_table_association" "mrp_nat_private-2-b" {
  subnet_id = aws_subnet.mrp_subnet_private-2.id
  route_table_id = aws_route_table.mrp-private.id
}

resource "aws_route_table_association" "mrp_nat_private-1-c" {
  subnet_id = aws_subnet.mrp_subnet_private-3.id
  route_table_id = aws_route_table.mrp-private.id
}

# RDS instances

resource "aws_db_subnet_group" "mariadb-subnet" {
  name = "mariadb-subnet"
  description = "AWS RDS subnet group"
  subnet_ids = [ aws_subnet.mrp_subnet_private-1.id, aws_subnet.mrp_subnet_private-2.id  ]
}


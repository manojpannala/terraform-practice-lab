# RDS instances

resource "aws_db_subnet_group" "mariadb-subnet" {
  name = "mariadb-subnet"
  description = "AWS RDS subnet group"
  subnet_ids = [ aws_subnet.mrp_subnet_private-1.id, aws_subnet.mrp_subnet_private-2.id  ]
}

# RDS Parameters

resource "aws_db_parameter_group" "mrp-mariadb-parameter" {
    name = "mrp-mariadb-parameters"
    family = "mariadb10.5"
    description = "MariaDB parameter group"

    parameter {
      name = "max_allowed_packet"
      value = "16777216"
    }
  
}
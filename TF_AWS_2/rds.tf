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

# RDS Instance properties

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mariadb"
  engine_version       = "10.5.8"
  instance_class       = "db.t2.micro"
  identifier           = "mariadb"
  name                 = "mariadb"
  username             = "root"
  password             = "mariadb141"
  db_subnet_group_name = aws_db_subnet_group.mariadb-subnet.name
  parameter_group_name = aws_db_parameter_group.mrp-mariadb-parameter.name
  skip_final_snapshot  = true
  multi_az             = "false"
  vpc_security_group_ids = [aws_security_group.allow-mariadb.id]
  storage_type         = "gp2"
  backup_retention_period = 10
  availability_zone = aws_subnet.mrp_subnet_private-1.availability_zone
  tags = {
    Name = "mrp-mariadb"
  }
}

# output "rds" {
#   value = aws_db_instance.mrp-mariadb.endpoint
# }
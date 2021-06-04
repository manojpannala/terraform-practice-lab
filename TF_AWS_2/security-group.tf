resource "aws_security_group" "allow-ssh" {
  vpc_id = aws_vpc.mrp_vpc.id
  name = "allow-ssh"
  description = "Security group to SSH into EC2"

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}


# Security group for MariaDB

resource "aws_security_group" "allow-mariadb" {
  vpc_id = aws_vpc.mrp_vpc.id
  name = "allow-mariadb"
  description = "Security group for MariaDB"

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      security_groups = [aws_security_group.allow-ssh.id]
  }

  tags = {
    Name = "allow-MariaDB"
  }
}
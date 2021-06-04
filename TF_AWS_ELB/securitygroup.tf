resource "aws_security_group" "mrp-elb-securitygroup" {
  vpc_id      = aws_vpc.mrpvpc.id
  name        = "mrp-elb-sg"
  description = "security group for Elastic Load Balancer"
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mrp-elb-sg"
  }
}

#Security group for the Instances
resource "aws_security_group" "mrp-instance" {
  vpc_id      = aws_vpc.mrpvpc.id
  name        = "mrp-instance"
  description = "security group for instances"
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.mrp-elb-securitygroup.id]
  }

  tags = {
    Name = "mrp-instance"
  }
}
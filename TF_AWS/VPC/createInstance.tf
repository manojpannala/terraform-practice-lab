resource "aws_key_pair" "mrp_key" {
    key_name = "mrp_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "MyFirstInstance" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mrp_key.key_name

  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  subnet_id = aws_subnet.mrp_subnet_public-3.id

  tags = {
    Name = "custom_instance"
  }
}

# EBS Resource Creation
resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "eu-central-1c"
  size = 20
  type = "gp2"
  tags = {
    Name = "Extra Volume Data"
  }
}

# Attach EBS Vol to EC2

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.MyFirstInstance.id
}
# AWS Key pair path
resource "aws_key_pair" "mrp_key" {
    key_name = "mrp_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

# Create EC2 Instance
resource "aws_instance" "MyFirstInstance" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  availability_zone = "eu-central-1a"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mrp_key.key_name
  
  depends_on = [
    aws_internet_gateway.mrp-igw
  ]


  # Add VPC, SG
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  subnet_id = aws_subnet.mrp_subnet_public-1.id

  tags = {
    Name = "custom_instance"
  }
}

output "public_ip" {
  value = aws_instance.MyFirstInstance.public_ip
}

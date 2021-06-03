# AWS Key pair path
resource "aws_key_pair" "mrp_key" {
    key_name = "mrp_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

# Create EC2 Instance
resource "aws_instance" "MyFirstInstance" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mrp_key.key_name
  disable_api_termination = true
  
  depends_on = [
    aws_internet_gateway.mrp-igw
  ]

  # Add Userdata
  user_data = file("installApache.sh")

  # Add VPC, SG
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  subnet_id = aws_subnet.mrp_subnet_public-3.id

  tags = {
    Name = "custom_instance"
  }
}

output "public_ip" {
  value = aws_instance.MyFirstInstance.public_ip
}

# EBS Resource Creation
# resource "aws_ebs_volume" "ebs-volume-1" {
#   availability_zone = "eu-central-1c"
#   size = 20
#   type = "gp2"
#   tags = {
#     Name = "Extra Volume Data"
#   }
# }

# # Attach EBS Vol to EC2

# resource "aws_volume_attachment" "ebs-volume-1-attachment" {
#   device_name = "/dev/xvdh"
#   volume_id = aws_ebs_volume.ebs-volume-1.id
#   instance_id = aws_instance.MyFirstInstance.id
# }
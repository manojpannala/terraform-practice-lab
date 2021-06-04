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
  iam_instance_profile = aws_iam_role_policy.s3-mrp-bucket-role-instanceprofile.name

  tags = {
    Name = "custom_instance"
  }
}

output "public_ip" {
  value = aws_instance.MyFirstInstance.public_ip
}

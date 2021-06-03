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

  # provisioner "file" {
  #     source = "installNginx.sh"
  #     destination = "/tmp/installNginx.sh"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/installNginx.sh",
  #     "sudo sed -i -e 's/\r$//' /tmp/installNginx.sh",  # Remove the spurious CR characters.
  #     "sudo /tmp/installNginx.sh",
  #   ]
  # }

  # connection {
  #   host        = coalesce(self.public_ip, self.private_ip)
  #   type        = "ssh"
  #   user        = var.INSTANCE_USERNAME
  #   private_key = file(var.PATH_TO_PRIVATE_KEY)
  # }
}
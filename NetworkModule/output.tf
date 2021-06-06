output "public_instance_ip" {
    value = ["${aws_instance.mrp_instance.public_ip}"]
  
}
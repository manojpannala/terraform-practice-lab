output "vpc_id" {
  value = aws_vpc.mrp_vpc.id
}
output "public_subnet_id" {
  value = aws_subnet.subnet_public.id
}
output "sg_22_id" {
  value = ["${aws_security_group.mrp_sg_22.id}"]
}
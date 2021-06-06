variable "region" {
  default = "eu-central-1"
}

variable "public_key_path" {
  description = "Public key path"
  default = "~/.ssh/mrp_key.pub"
}

variable "instance_ami" {
  description = "AMI for aws EC2 instance"
  default = "ami-0980c5102b5ef10cc"
}

variable "instance_type" {
  description = "type for aws EC2 instance"
  default = "t2.micro"
}

variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}

# Variable for Create Instance Module
variable "public_key_path" {
  description = "Public key path"
  default = "~/.ssh/mrp_key.pub"
}

variable "VPC_ID" {
    type = string
    default = ""
}

variable "ENVIRONMENT" {
    type    = string
    default = ""
}

variable "AWS_REGION" {
default = "eu-central-1"
}

variable "AMIS" {
    type = map
    default = {
        eu-central-1 = "ami-0980c5102b5ef10cc",
        eu-west-1 = "ami-06c5b2809791cf59c"
    }
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "PUBLIC_SUBNETS" {
  type = list
}
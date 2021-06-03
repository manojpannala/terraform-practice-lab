# variable "Security_Group"{
#     type = list
#     default = ["sg-24076", "sg-90890", "sg-456789"]
# }
variable "AWS_REGION" {
  default = "eu-central-1"
}

variable "AMIS" {
    type = map
    default = {
        eu-central-1 = "ami-0980c5102b5ef10cc"
        # us-east-2 = "ami-05692172625678b4e"
        # us-west-2 = "ami-0352d5a37fb4f603f"
        # us-west-1 = "ami-0f40c8f97004632f9"
    }
}

# variable "PATH_TO_PRIVATE_KEY" {
#   default = "mrp_key"
# }

# variable "PATH_TO_PUBLIC_KEY" {
#   default = "mrp_key.pub"
# }

# variable "INSTANCE_USERNAME" {
#   default = "ubuntu"
# }
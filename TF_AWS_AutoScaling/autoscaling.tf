# Create AutoScaling for EC2

resource "aws_launch_configuration" "mrp-launchconfig" {
    name_prefix = "mrp-launchconfig"
    image_id = lookup(var.AMIS, var.AWS_REGION)
    instance_type = "t2.micro"
    key_name = aws_key_pair.mrp_key.key_name
}

# AutoScaling Group
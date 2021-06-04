# Create AutoScaling for EC2

resource "aws_launch_configuration" "mrp-launchconfig" {
    name_prefix = "mrp-launchconfig"
    image_id = lookup(var.AMIS, var.AWS_REGION)
    instance_type = "t2.micro"
    key_name = aws_key_pair.mrp_key.key_name
}

# AutoScaling Group

resource "aws_autoscaling_group" "mrp-autoscaling" {
  name                      = "mrp-autoscaling"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 200
  health_check_type         = "EC2"
#   desired_capacity          = 4
  force_delete              = true
  placement_group           = aws_placement_group.test.id
  launch_configuration      = aws_launch_configuration.mrp-launchconfig.name
  vpc_zone_identifier       = ["eu-central-1a", "eu-central-1b"]

  tag {
    key                 = "Name"
    value               = "Custom EC2 Instance"
    propagate_at_launch = true
  }
}

# AutoScaling Configuration Policy - Security Alarm
resource "aws_autoscaling_policy" "mrp-cpu-policy" {
  name                   = "mrp-cpu-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 200
  autoscaling_group_name = aws_autoscaling_group.mrp-autoscaling.name
  policy_type = "SimpleScaling"
}
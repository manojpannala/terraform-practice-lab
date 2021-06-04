# Create AutoScaling for EC2

resource "aws_launch_configuration" "mrp-launchconfig" {
    name_prefix = "mrp-launchconfig"
    image_id = lookup(var.AMIS, var.AWS_REGION)
    instance_type = "t2.micro"
    key_name = aws_key_pair.mrp_key.key_name
}

#Generate Key
resource "aws_key_pair" "mrp_key" {
    key_name = "mrp_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
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

# Auto Scaling Cloud Watch Monitoring
resource "aws_cloudwatch_metric_alarm" "mrp-cpu-alarm" {
  alarm_name          = "mrp-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.mrp-autoscaling.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.mrp-cpu-policy.arn]
  actions_enabled = true
}

# Auto Descaling Policy 
resource "aws_autoscaling_policy" "mrp-cpu-policy-scaledown" {
  name                   = "mrp-cpu-policy-scaledown"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 200
  autoscaling_group_name = aws_autoscaling_group.mrp-autoscaling.name
  policy_type = "SimpleScaling"
}

# Auto Descaling CloudWatch
resource "aws_cloudwatch_metric_alarm" "mrp-cpu-alarm-scaledown" {
  alarm_name          = "mrp-cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.mrp-autoscaling.name
  }

  alarm_description = "Alarm once CPU usage decreases"
  alarm_actions     = [aws_autoscaling_policy.mrp-cpu-policy-scaledown.arn]
  actions_enabled = true
}

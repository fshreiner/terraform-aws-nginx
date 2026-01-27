resource "aws_autoscaling_group" "nginx" {
  name = "${var.project_name}-asg"

  min_size         = 1
  desired_capacity = 1
  max_size         = 3

  vpc_zone_identifier = [
    aws_subnet.private["a"].id,
    aws_subnet.private["b"].id
  ]

  launch_template {
    id      = aws_launch_template.nginx.id
    version = "$Latest"
  }

  target_group_arns = [
    aws_lb_target_group.nginx.arn
  ]

  health_check_type         = "ELB"
  health_check_grace_period = 60

  tag {
    key                 = "Name"
    value               = "${var.project_name}-nginx"
    propagate_at_launch = true
  }
}

# Scale Out Policy (subir instancias)
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale-out"
  autoscaling_group_name = aws_autoscaling_group.nginx.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 60
}

# Scale In Policy (descer instancias)
resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale-in"
  autoscaling_group_name = aws_autoscaling_group.nginx.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 60
}

# CloudWatch
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.project_name}-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.nginx.name
  }

  alarm_actions = [
    aws_autoscaling_policy.scale_out.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "${var.project_name}-cpu-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 3
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 30

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.nginx.name
  }

  alarm_actions = [
    aws_autoscaling_policy.scale_in.arn
  ]
}
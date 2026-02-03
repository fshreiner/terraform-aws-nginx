output "asg_name" {
  description = "Auto Scaling Group Name"
  value       = aws_autoscaling_group.this.name
}
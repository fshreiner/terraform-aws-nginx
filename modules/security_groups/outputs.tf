output "alb_sg_id" {
  description = "ID do Security Group do ALB"
  value       = aws_security_group.alb.id
}

output "ec2_sg_id" {
  description = "ID do Security Group das EC2"
  value       = aws_security_group.ec2.id
}
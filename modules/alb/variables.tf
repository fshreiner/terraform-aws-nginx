variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnets for ALB."
  type        = list(string)
}

variable "alb_sg_id" {
  description = "ALB Security Group"
  type        = string
}

variable "certificate_arn" {
  description = "ACM Certificate ARN"
  type = string
}
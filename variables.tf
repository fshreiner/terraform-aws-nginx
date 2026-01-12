variable "aws_region" {
  default     = "us-east-1"
  description = "default region"
}

variable "project_name" {
  default     = "terraform-nginx"
  description = "default name of project"
}

variable "instance_type" {
  default     = "t3.micro"
  description = "default instance type"
}

variable "my_ip" {
  description = "local IP for SSH access"
}
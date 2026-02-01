variable "project_name" {
  description = "Project Name (tags)"
  type = string
}

variable "vpc_cidr" {
  description = "VCP CIDR"
  type = string
}

variable "public_subnets" {
  description = "CIDRs list of public subnets"
  type = list(string)
}

variable "private_subnets" {
  description = "CIDRs list of private subnets"
  type = list(string)
}

variable "availability_zones" {
  description = "AZs list where subnets will be created"
  type = list(string)
}
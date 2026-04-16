variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  description = "Nome lógico (tag Project)"
  type        = string
  default     = "terraform-bootstrap"
}

variable "environment" {
  description = "Ambiente (tag)"
  type        = string
  default     = "lab"
}

variable "state_bucket_name" {
  type = string
}

variable "lock_table_name" {
  type = string
}

variable "dns_zone_name" {
  description = "Nome da zona pública no Route 53 (ex.: exemplo.com.br)"
  type        = string
  default     = "fabioshreiner.com.br"
}
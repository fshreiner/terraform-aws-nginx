variable "project_name" {
  description = "Nome lógico do projeto (tags e recursos)"
  type        = string
  default     = "nginx-lab"
}

variable "environment" {
  description = "Ambiente (tag)"
  type        = string
  default     = "lab"
}

variable "aws_region" {
  description = "Região AWS (deve ser a mesma do backend e dos outros stacks)"
  type        = string
  default     = "us-east-1"
}

variable "remote_state_bucket" {
  description = "Bucket S3 onde estão os states remotos"
  type        = string
  default     = "terraform-states-fshreiner"
}

variable "remote_state_key_network" {
  description = "Chave do state da stack network"
  type        = string
  default     = "network/terraform.tfstate"
}

variable "remote_state_key_foundation" {
  description = "Chave do state da stack foundation (bootstrap)"
  type        = string
  default     = "foundation/terraform.tfstate"
}

variable "domain_name" {
  description = "Domínio público da zona no Route 53 (ex.: exemplo.com.br). O certificado ACM será emitido para *.<domain_name>."
  type        = string
  default     = "fabioshreiner.com.br"
}

variable "app_record_hostname" {
  description = "Primeiro label do registro A do app (ex.: nginx -> nginx.<domain_name>)"
  type        = string
  default     = "nginx"
}

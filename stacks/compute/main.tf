data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = var.remote_state_key_network
    region = var.aws_region
  }
}

data "terraform_remote_state" "foundation" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = var.remote_state_key_foundation
    region = var.aws_region
  }
}

locals {
  network_out         = data.terraform_remote_state.network.outputs
  network_vpc_id      = try(local.network_out.vpc_id, null)
  network_public_ids  = try(local.network_out.public_subnet_ids, [])
  network_private_ids = try(local.network_out.private_subnet_ids, [])
}

resource "terraform_data" "require_network_stack" {
  lifecycle {
    precondition {
      condition = (
        local.network_vpc_id != null &&
        local.network_vpc_id != "" &&
        length(local.network_public_ids) > 0 &&
        length(local.network_private_ids) > 0
      )
      error_message = <<-EOT
        O state remoto da stack network (${var.remote_state_bucket}/${var.remote_state_key_network}) não contém outputs de VPC/subnets.
        Rode antes: cd stacks/network && terraform init && terraform apply
        Se você destruiu a stack network (ou nunca aplicou), recrie-a antes da stack compute.
      EOT
    }
  }
}

module "security_groups" {
  source = "../../modules/security_groups"

  depends_on = [terraform_data.require_network_stack]

  project_name = var.project_name
  vpc_id       = local.network_vpc_id
}

module "alb" {
  source = "../../modules/alb"

  depends_on = [terraform_data.require_network_stack]

  project_name      = var.project_name
  vpc_id            = local.network_vpc_id
  public_subnet_ids = local.network_public_ids
  alb_sg_id         = module.security_groups.alb_sg_id
  certificate_arn   = aws_acm_certificate_validation.wildcard.certificate_arn
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  depends_on = [terraform_data.require_network_stack]

  project_name       = var.project_name
  vpc_id             = local.network_vpc_id
  private_subnet_ids = local.network_private_ids
  ec2_sg_id          = module.security_groups.ec2_sg_id
  target_group_arn   = module.alb.target_group_arn
}

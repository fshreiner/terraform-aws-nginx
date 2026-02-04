provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../network/terraform.tfstate"
  }
}

module "security_groups" {
  source = "../../modules/security_groups"

  project_name = "nginx-lab"
  vpc_id       = data.terraform_remote_state.network.outputs.vpc_id
}

module "alb" {
  source = "../../modules/alb"

  project_name      = "nginx-lab"
  vpc_id            = data.terraform_remote_state.network.outputs.vpc_id
  public_subnet_ids = data.terraform_remote_state.network.outputs.public_subnet_ids
  alb_sg_id         = module.security_groups.alb_sg_id
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  project_name       = "nginx-lab"
  vpc_id             = data.terraform_remote_state.network.outputs.vpc_id
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  ec2_sg_id          = module.security_groups.ec2_sg_id
  target_group_arn   = module.alb.target_group_arn
}
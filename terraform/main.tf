provider "aws" {
  region = var.aws_region
}

module "rds" {
  source = "./modules/rds"

  local_name            = var.local_name
  vpc_id                = data.terraform_remote_state.network.outputs.vpc_id
  private_subnets       = data.terraform_remote_state.network.outputs.private_subnets
  db_username_parameter = "SPRING_DATASOURCE_USERNAME"
  db_password_parameter = "SPRING_DATASOURCE_PASSWORD"
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = var.bucket
    key    = "env:/${terraform.workspace}/network/terraform.tfstate"
    region = var.aws_region
  }
}

data "aws_availability_zones" "available" {}


locals {
  region = var.aws_region
  name   = "${var.local_name.name}-${var.local_name.env}"
  bucket = var.bucket


  azs = slice(data.aws_availability_zones.available.names, 0, var.vpc_subnets_count)


  tags = {
    Terraform = "true"
    Name      = var.local_name.name
    Env       = var.local_name.env
  }
}
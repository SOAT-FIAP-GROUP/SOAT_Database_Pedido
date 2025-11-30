data "aws_availability_zones" "available" {}

locals {
  region             = var.aws_region
  name               = "${var.local_name.name}-${var.local_name.env}"
  bucket             = var.bucket
  vpc_cidr           = var.vpc_cidr_block
  azs                = slice(data.aws_availability_zones.available.names, 0, var.vpc_subnets_count)
  instance_types     = ["t3.small"]

  tags = {
    Terraform = "true",
    Name      = var.local_name.name,
    Env       = var.local_name.env
  }
}
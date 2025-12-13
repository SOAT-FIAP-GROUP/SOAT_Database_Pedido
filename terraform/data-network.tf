data "aws_vpc" "this" {
  filter {
    name = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "private" {
  filter {
    name = "tag:Name"
    values = var.subnet_names
  }

  filter {
    name = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
}

data "aws_security_group" "rds" {
  filter {
    name = "group-name"
    values = [var.security_group_name]
  }

  vpc_id = data.aws_vpc.this.id
}


data "aws_db_subnet_group" "this" {
  name = var.db_subnet_group_name
}
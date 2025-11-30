data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "env:/${terraform.workspace}/network/terraform.tfstate"
    region = local.region
  }
}

data "aws_ssm_parameter" "db_username" {
  name = "SPRING_DATASOURCE_USERNAME"
}

data "aws_ssm_parameter" "db_password" {
  name = "SPRING_DATASOURCE_PASSWORD"
  with_decryption = true
}

resource "aws_security_group" "rds" {
  name        = "${local.name}_inbound_rds_from_eks"
  description = "Allow MariaDB inbound traffic at RDS from EKS nodes"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  tags        = local.tags
  depends_on = [data.terraform_remote_state.network]
}

resource "aws_security_group" "eks" {
  name        = "${local.name}_outboud_eks_to_rds"
  description = "Allow MariaDB outbound traffic at EKS nodes to RDS"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  tags        = local.tags
  depends_on = [data.terraform_remote_state.network]
}

resource "aws_db_subnet_group" "mydb" {
  name       = local.name
  subnet_ids = data.terraform_remote_state.network.outputs.private_subnets
  tags       = local.tags
}

resource "aws_db_instance" "mydb" {
  identifier             = local.name
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "mariadb"
  username               = data.aws_ssm_parameter.db_username.value
  password               = data.aws_ssm_parameter.db_password.value
  db_subnet_group_name   = aws_db_subnet_group.mydb.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  tags                   = local.tags
}
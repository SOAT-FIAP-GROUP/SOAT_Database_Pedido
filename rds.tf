data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "env:/dev/network/terraform.tfstate"
    region = local.region
  }
}

data "aws_ssm_parameter" "db_username" {
  name = "SPRING_DATASOURCE_USERNAME"
}

data "aws_ssm_parameter" "db_password" {
  name            = "SPRING_DATASOURCE_PASSWORD"
  with_decryption = true
}

resource "aws_security_group" "rds" {
  name   = "${local.name}-rds"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    cidr_blocks = [data.terraform_remote_state.network.outputs.vpc_cidr]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = local.tags
}

resource "aws_db_subnet_group" "db" {
  name       = local.name
  subnet_ids = data.terraform_remote_state.network.outputs.private_subnets
}

resource "aws_db_instance" "db" {
  identifier           = local.name
  engine               = "mariadb"
  instance_class       = "db.t3.micro"
  allocated_storage    = 5
  username             = data.aws_ssm_parameter.db_username.value
  password             = data.aws_ssm_parameter.db_password.value
  db_subnet_group_name = aws_db_subnet_group.db.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible  = false
  skip_final_snapshot  = true
  tags                 = local.tags
}
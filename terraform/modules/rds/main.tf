data "aws_ssm_parameter" "db_username" {
  name = var.db_username_parameter
}

data "aws_ssm_parameter" "db_password" {
  name            = var.db_password_parameter
  with_decryption = true
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.local_name.name}-${var.local_name.env}_rds_sg"
  description = "Allow MariaDB inbound traffic at RDS from EKS nodes"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Ajuste conforme necessário
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.local_name.name}-${var.local_name.env}-subnets"
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "rds_instance" {
  identifier             = "${var.local_name.name}-${var.local_name.env}-db"
  engine                 = "mariadb"
  engine_version         = "10.11"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  username               = data.aws_ssm_parameter.db_username.value
  password               = data.aws_ssm_parameter.db_password.value
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}


variable "db_instance_identifier" {
  type = string
  default = "mariadb-soat-pedido"
}


variable "vpc_name" {
  type = string
  default = "vpc-soat"
}


variable "subnet_names" {
  type = list(string)
  default = ["subnet-private1", "subnet-private2"]
}


variable "security_group_name" {
  type = string
  default = "security-group-rds-mariadb-pedido"
}


variable "db_subnet_group_name" {
  type = string
  default = "db-subnet-group-dev"
}
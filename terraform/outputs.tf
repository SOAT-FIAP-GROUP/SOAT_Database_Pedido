output "db_endpoint" {
  value = data.aws_db_instance.mariadb.endpoint
}


output "db_port" {
  value = data.aws_db_instance.mariadb.port
}


output "db_name" {
  value = data.aws_db_instance.mariadb.db_name
}


output "db_security_group_id" {
  value = data.aws_security_group.rds.id
}


output "private_subnet_ids" {
  value = data.aws_subnets.private.ids
}
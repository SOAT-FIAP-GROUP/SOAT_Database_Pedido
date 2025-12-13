data "aws_db_instance" "mariadb" {
  db_instance_identifier = var.db_instance_identifier
}
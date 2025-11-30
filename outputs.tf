# --- Security Groups ---
output "sg_rds_id" {
  value       = aws_security_group.rds.id
  description = "The ID of the RDS security group (inbound from EKS)"
}

output "sg_eks_id" {
  value       = aws_security_group.eks.id
  description = "The ID of the EKS security group (outbound to RDS)"
}

# --- DB Subnet Group ---
output "db_subnet_group_name" {
  value       = aws_db_subnet_group.mydb.name
  description = "The name of the DB subnet group"
}

output "db_subnet_group_id" {
  value       = aws_db_subnet_group.mydb.id
  description = "The ID of the DB subnet group"
}

# --- DB Instance ---
output "db_instance_id" {
  value       = aws_db_instance.mydb.id
  description = "The ID of the RDS DB instance"
}

output "db_instance_arn" {
  value       = aws_db_instance.mydb.arn
  description = "The ARN of the RDS DB instance"
}

output "db_instance_address" {
  value       = aws_db_instance.mydb.address
  description = "The DNS address of the RDS DB instance"
}

output "db_instance_endpoint" {
  value       = aws_db_instance.mydb.endpoint
  description = "The full connection endpoint (host:port) of the RDS DB instance"
}

output "db_instance_port" {
  value       = aws_db_instance.mydb.port
  description = "The port the RDS DB instance is listening on"
}

output "db_instance_username" {
  value       = aws_db_instance.mydb.username
  description = "The master username for the RDS DB instance"
  sensitive   = true
}

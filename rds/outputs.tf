output "postgres_endpoint" {
  description = "RDS PostgreSQL Endpoint"
  value       = aws_db_instance.postgres_db.endpoint
}

output "postgres_port" {
  description = "RDS PostgreSQL Port"
  value       = aws_db_instance.postgres_db.port
}
output "db_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "db_password" {
  value       = random_password.rds_password.result
  sensitive   = true
}

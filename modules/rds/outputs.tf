output "db_name" {
  value = aws_db_instance.db.id
}

output "db_endpoint" {
  value = aws_db_instance.db.endpoint
}

output "db_port" {
  value = aws_db_instance.db.port
}

output "db_security_group" {
  value = aws_security_group.db_sg.id
}

output "db_address" {
  value = aws_db_instance.db.address
}

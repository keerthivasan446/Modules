output "instance_security_group" {
  value = aws_security_group.instance.id
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.main.name
}
output "lb_security_group" {
  value = var.lb_type == "application" ? aws_security_group.load_balancer[0].id : null
}

output "load_balancer_dns" {
  value = aws_lb.main.dns_name
}

output "load_balancer_arn" {
  value = aws_lb.main.arn
}

output "load_balancer_arn_suffix" {
  value = aws_lb.main.arn_suffix
}

output "load_balancer_listener_port" {
  value = aws_lb_listener.main.port
}

output "key_name" {
    value = aws_key_pair.main.key_name
}

output "key_arn" {
    value = aws_key_pair.main.arn
}

output "key" {
    value = base64encode(tls_private_key.main.private_key_pem)
}
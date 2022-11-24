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

output "route53_record" {
  value = aws_route53_record.main.*.fqdn
}

output "aws_iam_role_id" {
  value = aws_iam_role.main.id
}

output "aws_iam_role_arn" {
  value = aws_iam_role.main.arn
}
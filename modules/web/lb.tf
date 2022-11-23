resource "aws_lb" "main" {
  name               = "${var.service}-${var.env}-${var.name}-lb"
  load_balancer_type = var.lb_type
  subnets            = var.lb_subnet_ids
  internal           = true
  security_groups    = var.lb_type == "application" ? [aws_security_group.load_balancer[0].id] : null
  idle_timeout       = var.lb_idle_timeout


  access_logs {
    bucket  = "${local.account_id}-access-logs"
    prefix  = "${var.service}/${var.env}/${var.name}"
    enabled = var.bucket_logs_enabled
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = "${var.service}-${var.env}-${var.name}-lb"
    }
  )

}

resource "aws_lb_target_group" "main" {
  name        = "${var.service}-${var.env}-${var.name}-tg"
  protocol    = var.lb_target_group_proto
  port        = var.lb_port
  vpc_id      = resource.aws_vpc.main.id
  target_type = var.target_type

  health_check {
    path     = var.healthcheck_path
    protocol = var.healthcheck_proto == "" ? var.lb_target_group_proto : var.healthcheck_proto
    matcher  = var.healthcheck_status_codes
  }

  stickiness {
    type            = "lb_cookie"
    cookie_duration = var.lb_stickiness_duration
    enabled         = var.lb_stickiness_enabled
  }

  tags = merge(
    local.common_tags,
    {
      "Name" = "${var.service}-${var.env}-${var.name}-tg"
    }
  )
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol
  ssl_policy        = var.lb_ssl_security_policy
  certificate_arn   = var.lb_certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.main.arn
    type             = "forward"
  }
}

resource "aws_security_group" "load_balancer" {
  count       = var.lb_type == "application" ? 1 : 0
  name        = "${var.service}-${var.env}-${var.name}-lb"
  description = "${var.service} ${var.env} ${var.name} lb security group"
  vpc_id      = resource.aws_vpc.main.id


  tags = merge(
    local.common_tags,
    map(
      "Name", "${var.service}-${var.env}-${var.name}-lb"
    )
  )
}

resource "aws_security_group_rule" "load_balancer_ingress" {
  count             = length(var.lb_ingress_cidrblock_list) >= 1 ? length(var.lb_ingress_cidrblock_list) : 0
  type              = "ingress"
  description       = element(var.lb_ingress_rule_description, count.index)
  from_port         = element(var.lb_ingress_from_port, count.index)
  to_port           = element(var.lb_ingress_to_port, count.index)
  protocol          = element(var.lb_ingress_proto, count.index)
  cidr_blocks       = [element(var.lb_ingress_cidrblock_list, count.index)]
  security_group_id = aws_security_group.load_balancer[0].id
}

resource "aws_security_group_rule" "load_balancer_egress" {
  count             = length(var.lb_egress_cidrblock_list) >= 1 ? length(var.lb_egress_cidrblock_list) : 0
  type              = "egress"
  description       = element(var.lb_egress_rule_description, count.index)
  from_port         = element(var.lb_egress_from_port, count.index)
  to_port           = element(var.lb_egress_to_port, count.index)
  protocol          = element(var.lb_egress_proto, count.index)
  cidr_blocks       = [element(var.lb_egress_cidrblock_list, count.index)]
  security_group_id = aws_security_group.load_balancer[0].id
}
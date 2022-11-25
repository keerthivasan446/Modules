resource "tls_private_key" "main" {
    algorithm                                   =   var.algorithm
    rsa_bits                                    =   var.rsa_bits
    ecdsa_curve                                 =   var.ecdsa_curve
}

resource "aws_key_pair" "main" {
    key_name                                    =   var.use_prefix ? null : var.name
    key_name_prefix                             =   var.use_prefix ? var.key_name : null
    public_key                                  =   tls_private_key.main.public_key_openssh
    tags                                        =   local.common_tags
}

resource "aws_iam_instance_profile" "main" {
  name = "${var.service}_${var.env}_${var.name}_profile"
  role = aws_iam_role.main.name
}


resource "aws_iam_role" "main" {
  name               = "${var.service}_${var.env}_${var.name}_role"
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy" "main" {
  name = "${var.service}_${var.env}_${var.name}_policy"
  policy = var.iam_role_policy
  role   = aws_iam_role.main.name
}

resource "aws_launch_configuration" "main" {
  name_prefix                 = "${substr(var.name, 0, 4)}-"
  image_id                    = var.instance_ami
  instance_type               = var.instance_type
  ebs_optimized               = true
  associate_public_ip_address = var.associate_public_ip_address
  enable_monitoring           = var.enable_monitoring
  iam_instance_profile        = aws_iam_instance_profile.main.name
  key_name                    = var.instance_ssh_key
  security_groups             = flatten([aws_security_group.instance.id, var.instance_additional_sgs])
  user_data                   = var.instance_userdata

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main" {
  name                = "${var.service}-${var.env}-${var.name}-asg"
  availability_zones  = var.subnet_ids == null ? var.availability_zones : null
  vpc_zone_identifier = var.subnet_ids
  desired_capacity    = var.instance_desired_cap
  max_size            = var.instance_max_cap
  min_size            = var.instance_min_cap
  health_check_type   = var.health_check_type
  target_group_arns   = flatten([aws_lb_target_group.main.arn, var.extra_targetgroups_arns])

  launch_configuration = aws_launch_configuration.main.id
  enabled_metrics = [
    "GroupDesiredCapacity",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupMinSize",
    "GroupMaxSize",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupStandbyCapacity",
    "GroupTerminatingCapacity",
    "GroupTerminatingInstances",
    "GroupTotalCapacity",
  "GroupTotalInstances"]

  dynamic "tag" {
    for_each = merge(local.common_tags, {
      Name = "${var.service}-${var.env}-${var.name}"
    })

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_security_group" "instance" {
  name        = "${var.service}-${var.env}-${var.name}-instance"
  description = "${var.service} ${var.env} ${var.name} instance security group"
  vpc_id      = var.vpc_id


  tags = merge(
    local.common_tags,
    tomap(
      {"Name"="${var.service}-${var.env}-${var.name}"}
    )
  )
}

resource "aws_security_group_rule" "instance_ingress_sg" {
  count                    = length(var.instance_ingress_source_sg) >= 1 ? length(var.instance_ingress_source_sg) : 0
  type                     = "ingress"
  description              = element(var.instance_ingress_sg_rule_description, count.index)
  from_port                = element(var.instance_ingress_sg_from_port, count.index)
  to_port                  = element(var.instance_ingress_sg_to_port, count.index)
  protocol                 = element(var.instance_ingress_sg_proto, count.index)
  source_security_group_id = element(var.instance_ingress_source_sg, count.index)
  security_group_id        = aws_security_group.instance.id
}

resource "aws_security_group_rule" "instance_ingress_cidr" {
  count             = length(var.instance_ingress_cidrblock) >= 1 ? length(var.instance_ingress_cidrblock) : 0
  type              = "ingress"
  description       = element(var.instance_ingress_cidr_rule_description, count.index)
  from_port         = element(var.instance_ingress_cidr_from_port, count.index)
  to_port           = element(var.instance_ingress_cidr_to_port, count.index)
  protocol          = element(var.instance_ingress_cidr_proto, count.index)
  cidr_blocks       = [element(var.instance_ingress_cidrblock, count.index)]
  security_group_id = aws_security_group.instance.id
}
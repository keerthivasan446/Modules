resource "aws_db_instance" "db" {
  identifier                          = "${var.org_name}-${var.env}-${var.name}-db"
  instance_class                      = var.instance_class
  iops                                = var.iops
  allocated_storage                   = var.allocated_storage
  storage_type                        = var.storage_type
  storage_encrypted                   = var.storage_encrypted
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  auto_minor_version_upgrade          = var.auto_minor_version_upgrade
  apply_immediately                   = var.apply_immediately
  backup_retention_period             = var.backup_retention_period
  backup_window                       = var.backup_window
  maintenance_window                  = var.maintenance_window
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  db_subnet_group_name                = aws_db_subnet_group.subnet_group.id
  vpc_security_group_ids              = [aws_security_group.db_sg.id]
  enabled_cloudwatch_logs_exports     = var.cloudwatch_logs_exports
  engine                              = var.engine
  engine_version                      = var.engine_version
  iam_database_authentication_enabled = var.iam_authentication_enabled
  username                            = var.username
  password                            = var.admin_password
  multi_az                            = var.multi_az
  skip_final_snapshot                 = var.skip_final_snapshot
  timezone                            = var.timezone
}

resource "aws_db_subnet_group" "subnet_group" {
  name                                = "database subnet group for ${var.org_name}-${var.env}-${var.name}"
  description                         = "${var.org_name}-${var.env}-${var.name}-subnet-group"
  subnet_ids                          = var.subnet_ids

  lifecycle {
    create_before_destroy             = true
  }

  tags = merge(
    local.common_tags,
    tomap(
      {"Name"="${var.org_name}-${var.env}-${var.name}"}
    )
  )
}

resource "aws_security_group" "db_sg" {
  name                                = "${var.org_name}-${var.env}-${var.name}-db"
  description                         = "${var.org_name} ${var.env} ${var.name} db instance security group"
  vpc_id                              = var.vpc_id


  tags = merge(
    local.common_tags,
    tomap(
      {"Name"="${var.org_name}-${var.env}-${var.name}"}
    )
  )

}

resource "aws_security_group_rule" "db_ingress_asg" {
  count                               = length(var.ingress_security_groups) >= 1 ? length(var.ingress_security_groups) : 0
  type                                = "ingress"
  description                         = "${var.org_name} ${var.env} ${var.name} db: Ingress from ${element(var.ingress_security_groups, count.index)}"
  from_port                           = var.db_port
  to_port                             = var.db_port
  protocol                            = var.db_ingress_asg_protocol
  source_security_group_id            = element(var.ingress_security_groups, count.index)
  security_group_id                   = aws_security_group.db_sg.id
}

resource "aws_security_group_rule" "db_egress" {
  count                               = length(var.db_egress_cidrblock) >= 1 ? length(var.db_egress_cidrblock) : 0
  type                                = "egress"
  description                         = element(var.db_egress_rule_description, count.index)
  from_port                           = element(var.db_egress_from_port, count.index)
  to_port                             = element(var.db_egress_to_port, count.index)
  protocol                            = element(var.db_egress_protocol, count.index)
  cidr_blocks                         = [element(var.db_egress_cidrblock, count.index)]
  security_group_id                   = aws_security_group.db_sg.id
}
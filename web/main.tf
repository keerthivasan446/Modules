resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

module "network" {
  source                = "../modules/network"
  org_name              = var.org_name
  env                   = var.env
  vpc_cidr_block        = var.vpc_cidr_block
  availability_zone     = var.availability_zone
  primary_subnet_name   = var.primary_subnet_name
  primary_subnet_cidr   = var.primary_subnet_cidr
  secondary_subnet_name = var.secondary_subnet_name
  secondary_subnet_cidr = var.secondary_subnet_cidr
  tertiary_subnet_name  = var.tertiary_subnet_name
  tertiary_subnet_cidr  = var.tertiary_subnet_cidr
  primary_extra_tags    = var.primary_extra_tags
  secondary_extra_tags  = var.secondary_extra_tags
  tertiary_extra_tags   = var.tertiary_extra_tags
}

module "web-app" {
  source             = "../modules/web"
  org_name           = var.org_name
  key_name           = var.key_name
  service            = var.service
  env                = var.env
  name               = var.name
  vpc_id             = module.network.vpc_id
  availability_zones = var.availability_zones
  #lc
  instance_ami                = var.instance_ami
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  enable_monitoring           = var.enable_monitoring
  instance_ssh_key            = module.web-app.key_name
  instance_userdata           = file("${path.module}/files/nginx.sh")
  #asg
  subnet_ids           = module.network.secondary_subnet_ids
  instance_desired_cap = var.instance_desired_cap
  instance_max_cap     = var.instance_max_cap
  instance_min_cap     = var.instance_min_cap
  health_check_type    = var.health_check_type
  #sg_instance
  instance_ingress_source_sg           = [module.web-app.lb_security_group]
  instance_ingress_sg_proto            = var.instance_ingress_sg_proto
  instance_ingress_sg_rule_description = var.instance_ingress_sg_rule_description
  instance_ingress_sg_from_port        = var.instance_ingress_sg_from_port
  instance_ingress_sg_to_port          = var.instance_ingress_sg_to_port

  #lb
  lb_type                     = var.lb_type
  lb_subnet_ids               = module.network.primary_subnet_ids
  bucket_logs_enabled         = var.bucket_logs_enabled
  lb_port                     = var.lb_port
  healthcheck_path            = var.healthcheck_path
  lb_target_group_proto       = var.lb_target_group_proto
  healthcheck_status_codes    = var.healthcheck_status_codes
  lb_stickiness_enabled       = var.lb_stickiness_enabled
  lb_listener_port            = var.lb_listener_port
  lb_listener_protocol        = var.lb_listener_protocol
  lb_ingress_cidrblock_list   = [module.network.vpc_id]
  lb_ingress_rule_description = var.lb_ingress_rule_description
  lb_ingress_from_port        = var.lb_ingress_from_port
  lb_ingress_to_port          = var.lb_ingress_to_port
  lb_ingress_proto            = var.lb_ingress_proto
  assume_role_policy          = data.aws_iam_policy_document.assume.json
  iam_role_policy             = data.aws_iam_policy_document.web.json
}

module "org-db" {

  source                      = "../modules/rds"
  org_name                    = var.org_name
  env                         = var.env
  name                        = var.name
  instance_class              = var.instance_class
  iops                        = var.iops
  allocated_storage           = var.allocated_storage
  storage_type                = var.storage_type
  storage_encrypted           = var.storage_encrypted
  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately           = var.apply_immediately
  backup_retention_period     = var.backup_retention_period
  backup_window               = var.backup_window
  maintenance_window          = var.maintenance_window
  copy_tags_to_snapshot       = var.copy_tags_to_snapshot
  cloudwatch_logs_exports     = var.cloudwatch_logs_exports
  engine                      = var.engine
  engine_version              = var.engine_version
  iam_authentication_enabled  = var.iam_authentication_enabled
  username                    = var.username
  admin_password              = random_password.password.result
  multi_az                    = var.multi_az
  skip_final_snapshot         = var.skip_final_snapshot
  subnet_ids                  = module.network.tertiary_subnet_ids
  vpc_id                      = module.network.vpc_id
  ingress_security_groups     = [module.web-app.lb_security_group]
  db_port                     = var.db_port
  db_ingress_asg_protocol     = var.db_ingress_asg_protocol
}
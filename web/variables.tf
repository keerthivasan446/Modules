variable "org_name" {type = string}
variable "name" {type = string}
variable "env" {type = string}
variable "vpc_cidr_block" {type = string}
variable "availability_zone" {type = list(string)}
variable "primary_subnet_name" {type = string}
variable "primary_subnet_cidr" {type = list(string)}
variable "secondary_subnet_name" {type = string}
variable "secondary_subnet_cidr" {type = list(string)}
variable "tertiary_subnet_name" {type = string}
variable "tertiary_subnet_cidr" {type = list(string)}
variable "primary_extra_tags" {type = map}
variable "secondary_extra_tags" {type = map}
variable "tertiary_extra_tags" {type = map}
variable "key_name" {type = string}
variable "service" {type = string}
variable "availability_zones" {type = list(string)}
variable "instance_ami" {type = string}
variable "instance_type" {type = string}
variable "associate_public_ip_address" {type = bool}
variable "enable_monitoring" {type = bool}
variable "instance_desired_cap" {type = string}
variable "instance_max_cap" {type = string}
variable "instance_min_cap" {type = string}
variable "health_check_type" {type = string}
variable "instance_ingress_sg_proto" {type = list}
variable "instance_ingress_sg_rule_description" {type = list(string)}
variable "instance_ingress_sg_from_port" {type = list(string)}
variable "instance_ingress_sg_to_port" {type = list(string)}
variable "lb_type" {type = string}
variable "bucket_logs_enabled" {type = bool}
variable "lb_port" {type = number}
variable "healthcheck_path" {type = string}
variable "lb_target_group_proto" {type = string}
variable "healthcheck_status_codes" {type = string}
variable "lb_stickiness_enabled" {type = string}
variable "lb_listener_port" {type = number}
variable "lb_listener_protocol" {type = string}
variable "lb_ingress_rule_description" {type = list(string)}
variable "lb_ingress_from_port" {type = list(string)}
variable "lb_ingress_to_port" {type =list(string)}
variable "lb_ingress_proto" {type = list(string)} 
variable "instance_class" {type = string}
variable "iops" {type = string}
variable "allocated_storage"  {type = number}
variable "storage_type" {type = string}
variable "storage_encrypted" {type = bool}
variable "allow_major_version_upgrade" {type = bool}
variable "auto_minor_version_upgrade" {type = bool}
variable "apply_immediately" {type = bool}
variable "backup_retention_period" {type = number}
variable "backup_window" {type = string}
variable "maintenance_window" {type = string}
variable "copy_tags_to_snapshot" {type = bool}
variable "cloudwatch_logs_exports" {type = list(string)}
variable "engine" {type = string}
variable "engine_version" {type = string}
variable "iam_authentication_enabled" {type = bool}
variable "username" {type = string}
variable "multi_az" {type = bool}
variable "skip_final_snapshot" {type = bool}
variable "db_port" {type = number}
variable "db_ingress_asg_protocol" {type = string}
variable org_name                                    {}
variable env                                        {}
variable name                                       {}
variable aws_region                                 { default = "eu-west2" }
variable vpc_id                                     {}
variable subnet_ids                                 {}
variable admin_password                             {}
variable ingress_security_groups                    {
                                                    type    = list
                                                    default = []
                                                    }
variable engine                                     { default = "MySQL" }
variable instance_class                             { default = "db.m5.large" }
variable internal_record_name                       { default = ""}
variable internal_zone_name                         { default = ""}
variable internal_zone_id                           { default = ""}
variable timezone                                   { default = null }
variable iops                                       { default = null }
variable allocated_storage                          { default = 50 }
variable storage_type                               { default = "gp2" }
variable storage_encrypted                          { default = true }
variable allow_major_version_upgrade                { default = false }
variable auto_minor_version_upgrade                 { default = true }
variable apply_immediately                          { default = true }
variable backup_retention_period                    { default = 7 }
variable backup_window                              { default = "22:59-23:59" }
variable maintenance_window                         { default = "Sun:01:00-Sun:03:00" }
variable copy_tags_to_snapshot                      { default = true }
variable cloudwatch_logs_exports                    { default = ["error", "general", "slowquery"] }
variable engine_version                             { default = "8.0" }
variable username                                   { default = "dbadmin" }
variable multi_az                                   { default = true }
variable db_port                                    { default = 3306 }
variable db_ingress_asg_protocol                    { default = "tcp" }
variable db_egress_cidrblock                        { default = ["10.0.0.0/8"] }
variable db_egress_rule_description                 { default = ["default egress rule for db"] }
variable db_egress_from_port                        { default = [0] }
variable db_egress_to_port                          { default = [0] }
variable db_egress_protocol                         { default = ["-1"] }
variable skip_final_snapshot                        { default = true }
variable iam_authentication_enabled                 { default = false }
variable severity                                   { default = "standard" }
variable rackspace_alarms_enabled                   { default = false }
variable rackspace_managed                          { default = true }
variable alarm_free_space_limit                     { default = 1024000000 }
variable alarm_write_iops_limit                     { default = 100 }
variable alarm_read_iops_limit                      { default = 100 }
variable alarm_cpu_limit                            { default = 60 }
variable event_categories                           { default = [] }
module "network" {
source                  = ../modules/network
org_name                = "org-1"
env                     = "dev"
vpc_cidr_block          = "10.0.0.0/16"
availability_zone       = ["eu-west-2a","eu-west-2b","eu-west-2c"]
primary_subnet_name     = "access"
primary_subnet_cidr     = ["10.1.0.0/24","10.1.1.0/24","10.1.2.0/24"]
secondary_subnet_name   = "core"
secondary_subnet_cidr   = ["10.2.0.0/24","10.2.1.0/24","10.2.2.0/24"]
tertiary_subnet_name    = "data"
tertiary_subnet_cidr    = ["10.3.0.0/24","10.3.1.0/24","10.3.2.0/24"]
primary_extra_tags      = {
    layer     = "acccess"
}
secondary_extra_tags    = {
    layer     = "core"
}
tetiary_extra_tags      = {
    layer     = "data"
}
}

module "web-app" {
source                                      = ../modules/web
service                                     = "web"
env                                         = "dev"
name                                        = "app1"
availability_zones                          = ["eu-west-2a","eu-west-2b","eu-west-2c"]
#lc
instance_ami                                = "ami-"
instance_type                               = "m5.xlarge"
associate_public_ip_address                 = false
enable_monitoring                           = true
instance_ssh_key                            = 
instance_userdata                           =
#asg
subnet_ids                                  = 
instance_desired_cap                        = "1"
instance_max_cap                            = "2"
instance_min_cap                            = "1"
health_check_type                           =
extra_targetgroups_arns                     =
#sg_instance
instance_ingress_source_sg                  =
instance_ingress_sg_rule_description        =
instance_ingress_sg_from_port               =
instance_ingress_sg_to_port                 =
instance_ingress_sg_proto                   =
instance_ingress_cidrblock                  =
instance_ingress_cidr_rule_description      =
instance_ingress_cidr_from_port             =
instance_ingress_cidr_to_port               =
instance_ingress_cidr_proto                 =
instance_ingress_cidrblock                  =
#lb
lb_type                                     = "application"
lb_subnet_ids                               = []
lb_idle_timeout                             = 
bucket_logs_enabled                         = true
lb_target_group_proto
lb_port                                     =
target_type                                 =
healthcheck_path                            =
healthcheck_proto                           =
lb_target_group_proto                       =
healthcheck_status_codes                    =
lb_stickiness_duration                      =
lb_stickiness_enabled                       =
lb_listener_port                            =
lb_listener_protocol                        =   
lb_ssl_security_policy                      =
lb_certificate_arn                          =
lb_ingress_cidrblock_list                   =
lb_ingress_rule_description                 =
lb_ingress_from_port                        =
lb_ingress_to_port                          =
lb_ingress_proto                            =
lb_egress_cidrblock_list                    =
lb_egress_rule_description                  =
lb_egress_from_port                         =
lb_egress_to_port                           =
lb_egress_proto                             =
}
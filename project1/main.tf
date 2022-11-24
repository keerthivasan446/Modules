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
instance_userdata                           = file("${path.module}/files/nginx.sh")
#asg
subnet_ids                                  = module.vpc_network.secondary_subnet_ids
instance_desired_cap                        = "1"
instance_max_cap                            = "2"
instance_min_cap                            = "1"
health_check_type                           = "ELB"
#sg_instance
instance_ingress_source_sg                  = [module.webapp.lb_security_group]
instance_ingress_sg_proto                   = ["http"]
instance_ingress_sg_rule_description        = ["inbound allow from loadbalancer to instance on 8080"]
instance_ingress_sg_from_port               = ["8080"]
instance_ingress_sg_to_port                 = ["8080"]

#lb
lb_type                                     = "application"
lb_subnet_ids                               = module.vpc_network.primary_subnet_ids
bucket_logs_enabled                         = true
lb_port                                     = ["8080"]
healthcheck_path                            = "/"
lb_target_group_proto                       = "HTTPS"
healthcheck_status_codes                    = "200"
lb_stickiness_enabled                       = "false"
lb_listener_port                            = 443
lb_listener_protocol                        = "HTTPS"
lb_ingress_cidrblock_list                   = module.network.vpc_id
lb_ingress_rule_description                 = ["ingress from VPC on port 443"]
lb_ingress_from_port                        = ["443"]
lb_ingress_to_port                          = ["443"]
lb_ingress_proto                            = ["HTTPS"]
}
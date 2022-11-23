variable "env"                                          {}
variable "org_name"                                     {}

#Autoscaling variables
variable "instance_ami"                                 {}
variable "instance_type"                                {}
variable "associate_public_ip_address"                  { default = false }
variable "enable_monitoring"                            { default = true }
variable "instance_ssh_key"                             {}
variable "instance_additional_sgs"                      {
                                                        type    = list
                                                        default = []
                                                        }
variable "name"                                         {}
variable "service"                                      {}


#load balancer variables
variable "lb_type"                                      { default = "application" }
variable "lb_subnet_ids"                                {}
variable "lb_target_group_proto"                        { default = "HTTP" }
variable "lb_port"                                      { default = 80 }
variable "target_type"                                  { default = "instance" }
variable "healthcheck_path"                             { default = "/health" }
variable "healthcheck_proto"                            {
                                                        type    = string  
                                                        default = ""
                                                        }   
variable "healthcheck_status_codes"                     {
                                                        type    = string
                                                        default = null
                                                        }
variable "lb_listener_port"                             { default = 8080 }
variable "lb_listener_protocol"                         { default = "HTTP" }
variable "lb_ssl_security_policy"                       { default = null }
variable "lb_certificate_arn"                           { default = null }
variable "instance_userdata"                            { default = null }

variable "subnet_ids"                                   { default = null }
variable "availability_zones"                           { default = null }
variable "instance_desired_cap"                         { default = null }
variable "instance_min_cap"                             { default = null }
variable "instance_max_cap"                             { default = null }
variable "health_check_type"                            { default = null }
variable "extra_targetgroups_arns"                      {}


variable "instance_ingress_source_sg"                   {
                                                        type = list
                                                        default = null
                                                        }
variable "instance_ingress_sg_rule_description"         {
                                                        type = list
                                                        default = null
                                                        }
variable "instance_ingress_sg_from_port"                {
                                                        type = list
                                                        default = null
                                                        }
variable "instance_ingress_sg_to_port"                  {
                                                        type = list
                                                        default = null
                                                        }
variable "instance_ingress_sg_proto"                    {
                                                        type = list
                                                        default = null
                                                        }
variable "instance_ingress_source_sg"                   {
                                                        type = list
                                                        default = null
                                                        }

variable "instance_ingress_cidrblock"                   {
                                                        type = list
                                                        default = null
                                                        }
variable "instance_ingress_cidr_rule_description"       {
                                                        type = list
                                                        default = null
                                                        }
variable "instance_ingress_cidr_from_port"              {
                                                        type = list
                                                        default = null
                                                        }
variable "instance_ingress_cidr_to_port"                {
                                                        type = list
                                                        default = null
                                                        }
variable "instance_ingress_cidr_proto"                  {
                                                        type = list
                                                        default = null
                                                        }
variable "instance_ingress_cidrblock"                   {
                                                        type = list
                                                        default = null
                                                        }
variable "lb_ingress_cidrblock_list"                   {
                                                        type = list
                                                        default = null
                                                        }
variable "lb_ingress_rule_description"                   {
                                                        type = list
                                                        default = null
                                                        }
variable "lb_ingress_from_port"                         {
                                                        type = list
                                                        default = null
                                                        }
variable "lb_ingress_to_port"                           {
                                                        type = list
                                                        default = null
                                                        }
variable "lb_egress_cidrblock_list"                     {
                                                        type = list
                                                        default = null
                                                        }
variable "lb_egress_rule_description"                   {
                                                        type = list
                                                        default = null
                                                        }
variable "lb_egress_from_port"                          {
                                                        type = list
                                                        default = null
                                                        }
variable "lb_egress_to_port"                            {
                                                        type = list
                                                        default = null
                                                        }
variable "lb_egress_proto"                              {
                                                        type = list
                                                        default = null
                                                        }
variable "lb_egress_cidrblock_list"                     { 
                                                        type = list
                                                        default = null
                                                        }
variable "env"                                          {}
variable "org_name"                                     {}
variable "vpc_id"                                       {}

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
variable "assume_role_policy"                           {}
variable "iam_role_policy"                              {}


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
variable "extra_targetgroups_arns"                      {
                                                        type    = list
                                                        default = []
                                                        }
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
variable "instance_ingress_cidrblock"                   {
                                                        type = list
                                                        default = []
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
variable "lb_ingress_cidrblock_list"                    {
                                                        type = list
                                                        default = []
                                                        }
variable "lb_ingress_rule_description"                  {
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
variable "lb_egress_rule_description"                   {
                                                        type    = list
                                                        default = ["default egress rule for load balancer"]
                                                        }
variable "lb_egress_from_port"                          {
                                                        type    = list
                                                        default = [0]
                                                        }
variable "lb_egress_to_port"                            {
                                                        type    = list
                                                        default = [0]
                                                        }
variable "lb_egress_proto"                              {
                                                        type    = list
                                                        default = ["-1"]
                                                        }
variable "lb_egress_cidrblock_list"                     {
                                                        type    = list
                                                        default = ["10.0.0.0/8"]
                                                        }
variable "lb_idle_timeout"                              { default = 300 }
variable "lb_stickiness_duration"                       {
                                                        type    = number
                                                        default = 86400
                                                        }
variable "key_name"                                         {
                                                        type       = string
                                                        }

variable "algorithm"                                    {
                                                        type       = string
                                                        default    = "RSA"
                                                        }

variable "rsa_bits"                                     {
                                                        type       = number
                                                        default    = 2048
                                                        }
variable "ecdsa_curve"                                  {
                                                        type       = string
                                                        default    = "P224"
                                                        }

variable "use_prefix"                                   {
                                                        type       = bool
                                                        default    = false
                                                        }

variable "extra_tags"                                   {
                                                        type       = map(string)
                                                        default    = {}
                                                        }
variable "bucket_logs_enabled"                          { default = true }
variable "lb_stickiness_enabled"                        {
                                                        type    = bool
                                                        default = true
                                                        }
variable "lb_ingress_proto"                             {
                                                        type    = list
                                                        default = ["-1"]
                                                        }
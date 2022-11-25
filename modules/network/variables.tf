variable "env"                                          {}
variable "org_name"                                     {}

#VPC Variables
variable "vpc_cidr_block"                               {}
variable "default_tenancy"                              {default = null}
variable "enable_dns_support"                           {default = true}
variable "enable_dns_hostnames"                         {default = true}

#subnet variables
variable "availability_zone"                            {
                                                        type        = list
                                                        default     = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
                                                        }
variable "primary_subnet_name"                          {}
variable "primary_subnet_cidr"                          {
                                                        type = list
                                                        default = null
                                                        }
variable "primary_extra_tags"                           {
                                                        type = map
                                                        default = {}
                                                        }

variable "secondary_subnet_name"                        {}
variable "secondary_subnet_cidr"                        {
                                                        type = list
                                                        default = null
                                                        }
variable "secondary_extra_tags"                         {
                                                        type = map
                                                        default = {}
                                                        }
variable "tertiary_subnet_name"                         {}
variable "tertiary_subnet_cidr"                         {
                                                        type = list
                                                        default = null
                                                        }
variable "tertiary_extra_tags"                          {
                                                        type = map
                                                        default = {}
                                                        }

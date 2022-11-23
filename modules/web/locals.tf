locals {
  common_tags = {
    "environment" = var.env
    "terraform"   = "true"
    "managedby"   = "rackspace"
  }
}

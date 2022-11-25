locals {
  account_id = data.aws_caller_identity.current.account_id
  common_tags = {
    "environment" = var.env
    "terraform"   = "true"
    "managedby"   = "rackspace"
  }
}

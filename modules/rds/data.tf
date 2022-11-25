

locals {
  account_id = data.aws_caller_identity.current.account_id

  common_tags = tomap(
    {
      "Name"="${var.org_name}-${var.env}-${var.name}",
      "Project"=var.org_name,
      "Environment"=var.env,
      "Terraform"="true",
      "ManagedBy"="rackspace",
      "Owner"="tsb"
    }
  )

}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_availability_zones" "az" {
  state = "available"
}
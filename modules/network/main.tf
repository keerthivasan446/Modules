resource "aws_vpc" "main" {
    cidr_block              = var.vpc_cidr_block
    instance_tenancy        = var.default_tenancy
    enable_dns_support      = var.enable_dns_support
    enable_dns_hostnames    = var.enable_dns_hostnames

    tags = merge(
        local.common_tags,
        {
            "Name"  = "${var.env}-${var.org_name}-vpc"
        }
    )
}

resource "aws_subnet" "primary" {
    count               = length(var.primary_subnet_cidr)
    vpc_id              = aws_vpc.main.id
    availability_zone   = element(var.availability_zone, count.index)
    cidr_block          = element(var.primary_subnet_cidr, count.index)

    tags = merge(
        local.common_tags, var.primary_extra_tags,
        {
            "Name"  = "${var.env}-${var.primary_subnet_name}"
        }
    )
}

resource "aws_subnet" "secondary" {
    count               = length(var.secondary_subnet_cidr)
    vpc_id              = aws_vpc.main.id
    availability_zone   = element(var.availability_zone, count.index)
    cidr_block          = element(var.secondary_subnet_cidr, count.index)

    tags = merge(
        local.common_tags, var.secondary_extra_tags,
        {
            "Name"    = "${var.env}-${var.secondary_subnet_name}-${count.index +1}${substr(element(var.availability_zone, count.index), 9, 1)}"
            "Layer"   = var.secondary_subnet_name
        }
    )
}

resource "aws_subnet" "tertiary" {
    count               = length(var.tertiary_subnet_cidr)
    vpc_id              = aws_vpc.main.id
    availability_zone   = element(var.availability_zone, count.index)
    cidr_block          = element(var.tertiary_subnet_cidr, count.index)

    tags = merge(
        local.common_tags, var.tertiary_extra_tags,
        {
            "Name"    = "${var.env}-${var.tertiary_subnet_name}-${count.index +1}${substr(element(var.availability_zone, count.index), 9, 1)}"
            "Layer"   = var.tertiary_subnet_name
        }
    )
}
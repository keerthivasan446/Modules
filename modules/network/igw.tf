resource "aws_internet_gateway" "gw" {
    count = var.igw_enabled = true ? 1 : 0
    vpc_id = aws_vpc.main.id
    tags = merge(
        local.common_tags, var.igw_extra_tags,
        {
            "Name"  = "${var.org_name}-${var.env}-${var.igw_name}"
        }
    )
}

resource "aws_subnet" "public" {
    count               = var.igw_enabled = true ? length(var.public_subnet_cidr) : 0
    vpc_id              = aws_vpc.main.id
    availability_zone   = element(var.availability_zone, count.index)
    cidr_block          = element(var.public_subnet_cidr, count.index)

    tags = merge(
        local.common_tags, var.public_extra_tags,
        {
            "Name"  = "${var.env}-${var.public_subnet_name}"
        }
    )
}

resource "aws_route_table" "main" {
  count         = var.igw_enabled = true ? 1 : 0
  vpc_id        = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    tomap(
      {"Name", "${var.org_name}${var.env}-${var.rt_name}"}
    )
  )
}

resource "aws_route" "main" {
  count                     = count = var.igw_enabled = true ? 1 : 0
  route_table_id            = resource.aws_route_table.main.id
  destination_cidr_block    = var.destination_cidr_block
  gateway_id                = resource.aws_internet_gateway.gw.id
}


resource "aws_route_table_association" "primary" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = resource.aws_subnet.public.[count.index]id
  route_table_id = resource.aws_route_table.main.id
}
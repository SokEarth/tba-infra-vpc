resource "aws_subnet" "private" {
  count = 2

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + 10)

  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    { Name = "${var.env}-private-${data.aws_availability_zones.available.names[count.index]}" },
    var.private_subnet_tags
  )
}

resource "aws_subnet" "public" {
  count = 2

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index)

  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    { Name = "${var.env}-public-${data.aws_availability_zones.available.names[count.index]}" },
    var.public_subnet_tags
  )
}
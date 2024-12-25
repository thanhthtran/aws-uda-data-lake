# Creating Route Tables for Internet gateway
resource "aws_route_table" "public_rt_1" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.cidr_all
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "${var.project}-public-rt-${var.zone1}"
  }
}
resource "aws_route_table" "public_rt_2" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.cidr_all
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "${var.project}-public-rt-${var.zone2}"
  }
}

resource "aws_route_table" "private_rt_1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.cidr_all
    nat_gateway_id = aws_nat_gateway.nat_a.id
  }

  tags = {
    Name = "${var.project}-private-rt-${var.zone1}"
  }
}
resource "aws_route_table" "private_rt_2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.cidr_all
    nat_gateway_id = aws_nat_gateway.nat_b.id
  }

  tags = {
    Name = "${var.project}-private-rt-${var.zone2}"
  }
}

# Creating Route Associations public subnets
resource "aws_route_table_association" "public_route_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt_1.id
}

resource "aws_route_table_association" "public_route_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_rt_2.id
}

resource "aws_route_table_association" "private_route_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_rt_1.id
}

resource "aws_route_table_association" "private_route_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_rt_2.id
}




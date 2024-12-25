resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_main_vpc
  #  enable_dns_support = true
  #  enable_dns_hostnames = true
  instance_tenancy = "default"
  tags = {
    Name = "${var.project}-main-vpc"
  }

}

# cretate internet gate way
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project}-internet-gate-way"
  }
}

# create public subnet
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr_pub1
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}${var.zone1}"
  tags = {
    Name = "${var.project}-vpc-public-${var.zone1}"
  }
}
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr_pub2
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}${var.zone2}"
  tags = {
    Name = "${var.project}-vpc-public-${var.zone2}"
  }
}

# Creating Private Subnets in VPC
resource "aws_subnet" "private_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr_private1
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}${var.zone1}"

  tags = {
    Name = "${var.project}-vpc-private-${var.zone1}"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr_private2
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}${var.zone2}"

  tags = {
    Name = "${var.project}-vpc-private-${var.zone2}"
  }
}



# NAT Gateway EIPs
resource "aws_eip" "nat_a" {
  domain = "vpc"
}

resource "aws_eip" "nat_b" {
  domain = "vpc"
}

# NAT Gateways
resource "aws_nat_gateway" "nat_a" {
  allocation_id = aws_eip.nat_a.id
  subnet_id     = aws_subnet.public_1.id

  tags = {
    Name = "${var.project}-natgw-1${var.zone1}"
  }

  depends_on = [aws_internet_gateway.ig]
}

resource "aws_nat_gateway" "nat_b" {
  allocation_id = aws_eip.nat_b.id
  subnet_id     = aws_subnet.public_2.id

  tags = {
    Name = "${var.project}-natgw-${var.zone2}"
  }

  depends_on = [aws_internet_gateway.ig]
}



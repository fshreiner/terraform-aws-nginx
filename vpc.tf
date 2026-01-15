resource "aws_vpc" "tf_nginx" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}

data "aws_availability_zones" "available_zones" {
  state = "available"
}

resource "aws_subnet" "public" {
  for_each = {
    a = 0
    b = 1 
  }

  vpc_id                  = aws_vpc.tf_nginx.id
  cidr_block              = "10.0.${each.value + 1}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[each.value]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-${each.key}"
    Tier = "public"
  }
}

resource "aws_nat_gateway" "nginx_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public["a"].id

  tags = {
    Name = "${var.project_name}-nat"
  }

  depends_on = [aws_internet_gateway.tf_nginx]
}

resource "aws_subnet" "private" {
  for_each = {
    a = 0
    b = 1 
  }

  vpc_id     = aws_vpc.tf_nginx.id
  cidr_block = "10.0.${each.value + 10}.0/24"
  availability_zone = data.aws_availability_zones.available.names[each.value]

  tags = {
    Name = "${var.project_name}-private-${each.key}"
    Tier = "private"
  }
}

resource "aws_internet_gateway" "tf_nginx" {
  vpc_id = aws_vpc.tf_nginx.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.tf_nginx.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_nginx.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.tf_nginx.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nginx_nat_a.id
  }

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
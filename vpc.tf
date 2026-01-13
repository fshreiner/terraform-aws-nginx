resource "aws_vpc" "tf_nginx" {
  cidr_block = "10.0.0.0/16"

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

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.tf_nginx.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-a"
  }
}

resource "aws_nat_gateway" "nginx_nat_a" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = "nat-gateway-A"
  }

  depends_on = [aws_internet_gateway.tf_nginx]
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.tf_nginx.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-b"
  }
}

# resource "aws_nat_gateway" "nginx_nat_b" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public_b.id

#   tags = {
#     Name = "nat-gateway-B"
#   }

#   depends_on = [aws_internet_gateway.tf_nginx]
# }

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.tf_nginx.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "${var.project_name}-private-subnet"
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
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.tf_nginx.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nginx_nat_a.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
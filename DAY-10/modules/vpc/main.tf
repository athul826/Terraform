resource "aws_vpc" "demo" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }

}

# create subnets for vpc 
resource "aws_subnet" "demo" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = var.subnet_cidrblock
  map_public_ip_on_launch = true
  availability_zone       = var.subnet_availabilityzone

  tags = {
    Name = var.subnet_name
  }

}

# create internet gateway for vpc 
resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = var.ineternet_gateway_name
  }

}

# create route table for subnets 
resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    gateway_id = aws_internet_gateway.demo.id
    cidr_block = var.route_table_cidrblock
  }

  tags = {
    Name = var.ineternet_gateway_name
  }

}

# associate route table with subnet 
resource "aws_route_table_association" "demo" {
  route_table_id = aws_route_table.demo.id
  subnet_id      = aws_subnet.demo.id

}

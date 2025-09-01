resource "aws_vpc" "demo" {
  cidr_block = var.vpc-cidr

  tags = {
    Name = var.vpc-name
  }

}

# create ig for vpc

resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = var.internet_gateway_name
  }

}

# create subnet for vpc

resource "aws_subnet" "demo" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = var.subnet-cidr
  map_public_ip_on_launch = true
  availability_zone       = var.subnet-availability_zone

  tags = {
    Name = var.subnet-name
  }


}

# create route table for vpc

resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    gateway_id = aws_internet_gateway.demo.id
    cidr_block = var.route_table_cidr

  }

  tags = {
    Name = var.route_table_name
  }

}

# subnet association

resource "aws_route_table_association" "demo" {
  subnet_id      = aws_subnet.demo.id
  route_table_id = aws_route_table.demo.id


}

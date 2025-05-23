resource "aws_vpc" "demo" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
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
  cidr_block              = var.subnet_cidr
  availability_zone       = var.subnet_availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_name
  }

}


# create routetable for vpc 
resource "aws_route_table" "name" {
  vpc_id = aws_vpc.demo.id 

  route {
    gateway_id = aws_internet_gateway.demo.id 
    cidr_block = var.routetable_cidr
  }
  
}

# subnet association with route table 
resource "aws_route_table_association" "demo" {
  route_table_id = aws_route_table.name.id 
  subnet_id = aws_subnet.demo.id 
  
}
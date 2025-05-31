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
    Name = var.aws_internet_gateway_name
  }

}

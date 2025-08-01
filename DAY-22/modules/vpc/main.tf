resource "aws_vpc" "demo" {
    cidr_block = var.vpc-cidr-block

    tags = {
        Name = var.vpc-name

    }

}

# create internet gateway
resource "aws_internet_gateway" "demo" {
    vpc_id = aws_vpc.demo.id

    tags = {

        Name = var.ig-name

    }

}

# create subnet for vpc
resource "aws_subnet" "vpc" {
    vpc_id = aws_vpc.demo.id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.subnent_availabilityzone
    map_public_ip_on_launch = true

    tags = {
      Name = var.subnet-name

    }
}

# create subnet for vpc
resource "aws_route_table" "demo" {
    vpc_id = aws_vpc.demo.id

    route {
        gateway_id = aws_internet_gateway.demo.id
        cidr_block = var.aws-route_table_cidr
    }

    tags = {
        Name = var.aws-route_table_name
    }

}

# subnet associatioin with route table
resource "aws_route_table_association" "name" {
    route_table_id = aws_route_table.demo.id
    subnet_id = aws_subnet.vpc.id

}


resource "aws_vpc" "demo" {
    cidr_block = var.vpc_cidr_block

    tags = {
      Name = var.vpc_name
    }


}

# create internet gateway for vpc
resource "aws_internet_gateway" "demo" {
    vpc_id = aws_vpc.demo.id

    tags = {
        Name = var.ig_name
    }

}

# create subnets for vpc
resource "aws_subnet" "demo" {
    vpc_id = aws_vpc.demo.id
    availability_zone = var.subnent_availabilityzone
    map_public_ip_on_launch = true
    cidr_block = var.subnet_cidr_block

    tags = {
        Name = var.subnet_name
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

# associate routetable with subnet

resource "aws_route_table_association" "demo" {
    route_table_id = aws_route_table.demo.id
    subnet_id = aws_subnet.demo.id
}
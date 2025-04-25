provider "aws" {
  region = "us-east-1"

}
# create aws-key-pair 
resource "aws_key_pair" "demo" {
    key_name = "athul-terraform-demo"
    public_key = file("C:\\Users\\Athul Tharol\\.ssh\\id_ed25519.pub")
  
}

resource "aws_vpc" "demo" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }

}

# creat subnet for vpc 
resource "aws_subnet" "demo" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = var.subnet_cidrblock
  availability_zone       = var.subnet_availabilityzone
  map_public_ip_on_launch = "true"

  tags = {
    Name = var.subnet_name
  }

}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = var.aws_internet_gateway_name
  }

}

# create route table for subnets 

resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    gateway_id = aws_internet_gateway.demo.id
    cidr_block = var.route_table_cidr
  }

  tags = {
    Name = var.aws_route_table_name
  }

}

# associate route table with subnet 
resource "aws_route_table_association" "demo" {
  route_table_id = aws_route_table.demo.id
  subnet_id      = aws_subnet.demo.id


}

# create security group for instance 
resource "aws_security_group" "demo" {
  vpc_id = aws_vpc.demo.id
  name   = var.security_group_name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.security_ingress_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.security_egress_cidr]
  }

}

# create instance 
resource "aws_instance" "demo" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    =  aws_key_pair.demo.key_name             
  subnet_id                   = aws_subnet.demo.id
  vpc_security_group_ids      = [aws_security_group.demo.id]
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
    # ✅ Provisioner block starts here
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo systemctl start nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu" # Or ec2-user for Amazon Linux
      private_key = file("C:\\Users\\Athul Tharol\\.ssh\\id_ed25519")  # Your private key path
      host        = self.public_ip
    }
  }

}

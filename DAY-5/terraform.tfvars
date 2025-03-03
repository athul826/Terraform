vpc_cidr = "10.0.0.0/16"
vpc_tenancy = "default"
vpc_name = "demo-vpc"

# create subnet part for vpc
subnet_cidr = "10.0.0.0/24"
subnet_name = "public-demo"
subnet_availability = "us-east-1a"

# value for route-tables
route-table-cidr = "0.0.0.0/0"

# create security group rule for intance
securiy-group-name = "my-security"
securiy-group-cidr = "0.0.0.0/0"

# create instance 
ami = "ami-04b4f1a9cf54c11d0"
insance-type = "t2.micro"
instance-name = "my-instance"





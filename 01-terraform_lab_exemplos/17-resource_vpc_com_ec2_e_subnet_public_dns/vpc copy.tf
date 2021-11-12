resource "aws_vpc" "my_vpc" {
  cidr_block = "10.80.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "TerraformVPCPublicSubnet-vinicius"
  }
}

resource "aws_subnet" "my_subnet1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.80.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf-lab-vinicius-subnet1"
  }
}

resource "aws_subnet" "my_subnet2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.80.20.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf-lab-vinicius-subnet2"
  }
}

resource "aws_subnet" "my_subnet3" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.80.30.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf-lab-vinicius-subnet3"
  }
}

resource "aws_subnet" "my_subnet4" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.80.40.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf-lab-vinicius-subnet4"
  }
}
# resource "aws_internet_gateway" "gw" {
#   vpc_id = aws_vpc.my_vpc.id

#   tags = {
#     Name = "aws_internet_gateway_terraform_vinicius"
#   }
# }

resource "aws_route_table" "rt_terraform" {
  vpc_id = aws_vpc.my_vpc.id

  route = [
      # {
      #   carrier_gateway_id         = ""
      #   cidr_block                 = "0.0.0.0/0"
      #   destination_prefix_list_id = ""
      #   egress_only_gateway_id     = ""
      #   gateway_id                 = aws_internet_gateway.gw.id
      #   instance_id                = ""
      #   ipv6_cidr_block            = ""
      #   local_gateway_id           = ""
      #   nat_gateway_id             = ""
      #   network_interface_id       = ""
      #   transit_gateway_id         = ""
      #   vpc_endpoint_id            = ""
      #   vpc_peering_connection_id  = ""
      # }
  ]

  tags = {
    Name = "route_table_terraform_vinicius"
  }
}

resource "aws_route_table" "rt_terraform2" {
  vpc_id = aws_vpc.my_vpc.id

  route = [
  ]

  tags = {
    Name = "route_table2_terraform_vinicius"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.my_subnet1.id
  route_table_id = aws_route_table.rt_terraform.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.my_subnet2.id
  route_table_id = aws_route_table.rt_terraform.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.my_subnet3.id
  route_table_id = aws_route_table.rt_terraform.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.my_subnet4.id
  route_table_id = aws_route_table.rt_terraform2.id
}

# resource "aws_network_interface" "my_subnet" {
#   subnet_id           = aws_subnet.my_subnet.id
#   private_ips         = ["172.17.10.100"] # IP definido para instancia
#   # security_groups = ["${aws_security_group.allow_ssh1.id}"]

#   tags = {
#     Name = "primary_network_interface my_subnet"
#   }
# }
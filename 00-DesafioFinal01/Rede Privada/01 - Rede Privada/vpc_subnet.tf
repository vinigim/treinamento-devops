# provider "aws" {
#   region = "sa-east-1"
# }

resource "aws_vpc" "my_vpc" {
  cidr_block = "172.80.0.0/16"

  tags = {
    Name = "vini-vpc-desafio"
  }
}

resource "aws_subnet" "my_subnet_a" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.80.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "vini-subnet-1a"
  }
}

resource "aws_subnet" "my_subnet_b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.80.20.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "vini-subnet-1b"
  }
}

resource "aws_subnet" "my_subnet_c" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.80.30.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "vini-subnet-1c"
  }
}

resource "aws_subnet" "my_subnet_c_priv" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.80.40.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "vini-subnet-1c-priv"
  }
}

resource "aws_route_table" "rt_priv_desafio" {
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
    Name = "route_table_vini_priv_desafio"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.my_subnet_c_priv.id
  route_table_id = aws_route_table.rt_priv_desafio.id
}
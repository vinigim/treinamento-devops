resource "aws_subnet" "vini_sub_tf_priv_0" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.20.10.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "vini_sub_tf_priv_0"
  }
}

resource "aws_subnet" "vini_sub_tf_priv_1" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.20.20.0/24"
  availability_zone = "sa-east-1b"

  tags = {
    Name = "vini_sub_tf_priv_1"
  }
}

resource "aws_subnet" "vini_sub_tf_priv_2" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.20.30.0/24"
  availability_zone = "sa-east-1c"

  tags = {
    Name = "vini_sub_tf_priv_2"
  }
}

resource "aws_route_table" "rt_vini_tf_priv" {
  vpc_id = var.vpc_id

  route = [
    {
      carrier_gateway_id         = ""
      cidr_block                 = "0.0.0.0/0"
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      gateway_id                 = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      nat_gateway_id             = aws_nat_gateway.nat_gatway_vini.id
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    }
  ]

  tags = {
    Name = "rt_vini_tf_priv"
  }
}

resource "aws_route_table_association" "priv_0" {
  subnet_id      = aws_subnet.vini_sub_tf_priv_0.id
  route_table_id = aws_route_table.rt_vini_tf_priv.id
}

resource "aws_route_table_association" "priv_1" {
  subnet_id      = aws_subnet.vini_sub_tf_priv_1.id
  route_table_id = aws_route_table.rt_vini_tf_priv.id
}

resource "aws_route_table_association" "priv_2" {
  subnet_id      = aws_subnet.vini_sub_tf_priv_2.id
  route_table_id = aws_route_table.rt_vini_tf_priv.id
}
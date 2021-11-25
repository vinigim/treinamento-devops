resource "aws_subnet" "vini_sub_tf_public_0" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.20.73.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "vini_sub_tf_public_0"
  }
}

resource "aws_subnet" "vini_sub_tf_public_1" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.20.74.0/24"
  availability_zone = "sa-east-1b"

  tags = {
    Name = "vini_sub_tf_public_1"
  }
}

resource "aws_subnet" "vini_sub_tf_public_2" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.20.75.0/24"
  availability_zone = "sa-east-1c"

  tags = {
    Name = "vini_sub_tf_public_2"
  }
}

resource "aws_route_table" "rt_vini_tf_public" {
  vpc_id = var.vpc_id

  route = [
    {
      carrier_gateway_id         = ""
      cidr_block                 = "0.0.0.0/0"
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      gateway_id                 = var.internet_gw
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      nat_gateway_id             = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    }
  ]

  tags = {
    Name = "rt_vini_tf_public"
  }
}

resource "aws_route_table_association" "public_0" {
  subnet_id      = aws_subnet.vini_sub_tf_public_0.id
  route_table_id = aws_route_table.rt_vini_tf_public.id
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.vini_sub_tf_public_1.id
  route_table_id = aws_route_table.rt_vini_tf_public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.vini_sub_tf_public_2.id
  route_table_id = aws_route_table.rt_vini_tf_public.id
}
resource "aws_eip" "vini_eip" {

}
resource "aws_nat_gateway" "nat_gatway_vini" {
  allocation_id = aws_eip.vini_eip.id
  subnet_id     = "subnet-048155f5678ed3564"

  tags = {
    Name = "Vini-NAT-GW"
  }

}
resource "aws_route_table" "nat_gateway" {
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
    Name = "vini-RT-NAT-GW"
  }
}
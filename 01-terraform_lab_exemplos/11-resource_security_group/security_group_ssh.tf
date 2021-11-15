# https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest/submodules/ssh#input_auto_computed_egress_rules
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

# ingress = [  # inbound
# egress = [ # outbound

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh-vinicius2"
  description = "Allow SSH inbound traffic"
  vpc_id = "vpc-00b1a90a7a03befbb"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups = null,
      self            = null
    },
    {
      description      = "HTTP from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups = null,
      self            = null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids  = null,
      security_groups  = null,
      self             = null,
      description      = "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "allow_ssh-vinicius2"
  }
}
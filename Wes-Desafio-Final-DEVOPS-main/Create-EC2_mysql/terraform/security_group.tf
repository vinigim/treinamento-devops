
resource "aws_security_group" "mysql" {
  name        = "vini_priv_mysql"
  description = "acessos inbound traffic"
  vpc_id = var.vpc_id 
  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null,
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },
    {
      cidr_blocks      = []
      description      = "Libera acesso dos workers para o mysql"
      from_port        = 3306
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = ["${var.sg_workers}"]
      self             = false
      to_port          = 3306
    },
    
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = [],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "vini_priv_mysql"
  }
}

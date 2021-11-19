provider "aws" {
  region = "sa-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

resource "aws_instance" "maquina_master" {
  subnet_id     = "subnet-048155f5678ed3564"
  ami           = "ami-07c267c1d2395046a"
  instance_type = "t2.large"
  key_name = "chave_key_vini_06"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 110
  }
  tags = {
    Name = "vini-k8s-master"
  }
  vpc_security_group_ids = [aws_security_group.acessos_master_single_master.id]
  depends_on = [
    aws_instance.workers,
  ]
}

resource "aws_instance" "workers" {
  subnet_id     = "subnet-048155f5678ed3564"
  ami           = "ami-07c267c1d2395046a"
  instance_type = "t2.medium"
  key_name = "chave_key_vini_06"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 110
  }
  tags = {
    Name = "vini-k8s-node-${count.index}"
  }
  vpc_security_group_ids = [aws_security_group.acessos_workers_single_master.id]
  count         = 3
}

resource "aws_security_group" "acessos_master_single_master" {
  name        = "acessos_master_single_master"
  description = "acessos_master_single_master inbound traffic"
  vpc_id = "vpc-00b1a90a7a03befbb"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["${chomp(data.http.myip.body)}/32"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },
    {
      description      = "liberando para mundo"
      from_port        = 30000
      to_port          = 30000
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },
    {
      cidr_blocks      = []
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = [
        "sg-00cd8e52b361a593e",
      ]
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 65535
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "vini_acessos_master_single_master"
  }
}


resource "aws_security_group" "acessos_workers_single_master" {
  name        = "acessos_workers_single_master"
  description = "acessos_workers_single_master inbound traffic"
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
      security_groups: null,
      self: null
    },
    {
      cidr_blocks      = []
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = [
        "${aws_security_group.acessos_master_single_master.id}",
      ]
      self             = false
      to_port          = 0
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "vini_acessos_workers_single_master"
  }
}


# terraform refresh para mostrar o ssh
output "maquina_master" {
  value = [
    "master - ${aws_instance.maquina_master.public_ip} - ssh -i ~/Desktop/devops/treinamentoItau ubuntu@${aws_instance.maquina_master.public_dns}",
    "master sg - ${aws_security_group.acessos_master_single_master.id}",
    "worker sg - ${aws_security_group.acessos_workers_single_master.id}"
  ]
}

# terraform refresh para mostrar o ssh
output "aws_instance_e_ssh" {
  value = [
    for key, item in aws_instance.workers :
      "worker ${key+1} - ${item.public_ip} - ssh -i ~/Desktop/devops/treinamentoItau ubuntu@${item.public_dns}"
    
  ]
}
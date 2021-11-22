provider "aws" {
  region = "us-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

resource "aws_instance" "maquina_master" {
  subnet_id     = "subnet-0a4feadfc5e155bb9"
  ami           = "ami-0824adb9d747c695b"
  instance_type = "t3.large"
  key_name = "pair_key_vini_desafio"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 110
  }
  tags = {
    Name = "vini-k8s-master-desafio"
  }
  vpc_security_group_ids = [aws_security_group.acessos_master_single_master.id]
  depends_on = [
    aws_instance.workers,
  ]
}

resource "aws_instance" "workers" {
  subnet_id     = "subnet-0c5ba748301836b06"
  ami           = "ami-0824adb9d747c695b"
  instance_type = "t2.large"
  key_name = "pair_key_vini_desafio"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 110
  }
  tags = {
    Name = "vini-k8s-node-${count.index}-desafio"
  }
  vpc_security_group_ids = [aws_security_group.acessos_workers_single_master.id]
  count         = 3
}

resource "aws_security_group" "acessos_master_single_master" {
  name        = "acessos_master_single_master"
  description = "acessos_master_single_master inbound traffic"
  vpc_id = "vpc-0fde8268982e3bfb1"

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
    # comentar na primeira vez que rodar, descomentar quando tivermos o sg dos workers
    {
      cidr_blocks      = []
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = [
        "sg-051cf1485e5a9d8e7",
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
  vpc_id = "vpc-0fde8268982e3bfb1"

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
    "master - ${aws_instance.maquina_master.public_ip} - ssh -i ~/Desktop/devops/treinamentoItau ubuntu@ ${aws_instance.maquina_master.public_dns}",
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

output "k8s-master" {
  value = [
    # "vini-k8s-master-desafio - ${aws_instance.maquina_master.private_ip} - ssh -i /home/ubuntu/.ssh/id_rsa ubuntu@${aws_instance.maquina_master.public_ip} -o ServerAliveInterval=60"
    "vini-k8s-master-desafio - ${aws_instance.maquina_master.private_ip} - ssh -i /home/ubuntu/.ssh/id_rsa ubuntu@${aws_instance.maquina_master.public_dns} -o ServerAliveInterval=60"
  ]
}

output "output-k8s_workers" {
  value = [
    for key, item in aws_instance.workers:
    "vini-k8s-node-${key+1}-desafio - ${item.private_ip} - ssh -i /home/ubuntu/.ssh/id_rsa ubuntu@${item.public_dns} -o ServerAliveInterval=60"
  ]
}
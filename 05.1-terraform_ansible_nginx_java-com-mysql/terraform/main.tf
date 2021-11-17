provider "aws" {
  region = "sa-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"] # ou ["099720109477"] ID master com permissão para busca

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*"] # exemplo de como listar um nome de AMI - 'aws ec2 describe-images --region us-east-1 --image-ids ami-09e67e426f25ce0d7' https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html
  }
}

resource "aws_instance" "vini_nginx_java_mysql" {
  subnet_id     = "subnet-048155f5678ed3564"
  ami           = data.aws_ami.ubuntu.id
  # ami= "ami-07c267c1d2395046a"
  key_name = "chave_key_vini_03"
  instance_type = "t3.medium"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 110
  }
  tags = {
    Name = "vini_ansible_com_nginx_java_mysql"
  }
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
}
resource "aws_key_pair" "chave_key" {
  key_name   = "chave_key_vini_03"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSF0gO/u4lEqDgvZO1H4WlJGynP9RJzPARRuspvOurl2MAvv6LZG+tJiIKjZdcGbGtSYhpy4EHZOdUNRwt8gf1ENlAW0Ao85qm/VXYmv0o5cfcbl1j40pTJDw5JV2M7MEBnTDfs7EytIAOFmsVLdyhTHqqBWT82Q1lZ4ISutO340wH5eyqqgp+AFyihPJPJW4Y3WqYf89GSKSxia3MMgZ0DctPUnB/ssUKF0tkKq43yhn5+P3KXLU/Udca9UXTLe+ehNQnX7kfPWnm445vKEZKRbbv7xnRhNxYdzBbkF0S650zmJHEFUWUZcovA/00LeYC109LRCvby5FruCy3ngc2RdUvUX7qmd7new9oMZVQzCL96A8tMagn0xanUxa86AhU+Yc3HE0YfOYGSQrS7ZYRGI0fC9mIfuhwgf6GCjYswAPVynFC94O4gVv+Zqg9BKQitRiF/ct7p3+NApG9X5/CKJOCtynIkP9xZUwC2KemTME0B1GhSgbdPEKIFoHQle8= ubuntu@ec2-vinicius-large"
}
resource "aws_security_group" "acessos" {
  name        = "acessos nginx java mysql"
  description = "acessos nginx java mysql inbound traffic"
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
      description      = "Acesso HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["${chomp(data.http.myip.body)}/32"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups: null,
      self: null
    }
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
    Name = "acessos nginx java mysql"
  }
}

# terraform refresh para mostrar o ssh
output "aws_instance_e_ssh" {
  value = [
    "PUBLIC_DNS=${aws_instance.vini_nginx_java_mysql.public_dns}",
    "PUBLIC_IP=${aws_instance.vini_nginx_java_mysql.public_ip}",
    "ssh -i /home/ubuntu/.ssh/id_rsa ubuntu@${aws_instance.vini_nginx_java_mysql.public_dns} -o ServerAliveInterval=60"
  ]
}

# para liberar a internet interna da maquina, colocar regra do outbound "Outbound rules" como "All traffic"
# ssh -i ../../id_rsa_itau_treinamento ubuntu@ec2-3-93-240-108.compute-1.amazonaws.com
# conferir 

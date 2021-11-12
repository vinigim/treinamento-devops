provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web1" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t3.micro"
  key_name = "pair_key_vinicius_us" # key chave publica cadastrada na AWS 
  subnet_id               =  aws_subnet.my_subnet1.id # vincula a subnet direto e gera o IP automático
  #private_ip              = "10.80.0.1"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  vpc_security_group_ids  = [
    "${aws_security_group.allow_ssh_terraform.id}",
  ]

  tags = {
    Name = "ec2-1-vinicius-us"
  }
}

resource "aws_instance" "web2" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t3.micro"
  key_name = "pair_key_vinicius_us" # key chave publica cadastrada na AWS 
  subnet_id               =  aws_subnet.my_subnet2.id # vincula a subnet direto e gera o IP automático
  #private_ip              = "10.80.0.1"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  vpc_security_group_ids  = [
    "${aws_security_group.allow_ssh_terraform.id}",
  ]

  tags = {
    Name = "ec2-2-vinicius-us"
  }
}

resource "aws_instance" "web3" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t3.micro"
  key_name = "pair_key_vinicius_us" # key chave publica cadastrada na AWS 
  subnet_id               =  aws_subnet.my_subnet3.id # vincula a subnet direto e gera o IP automático
  #private_ip              = "10.80.0.1"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  vpc_security_group_ids  = [
    "${aws_security_group.allow_ssh_terraform.id}",
  ]

  tags = {
    Name = "ec2-3-vinicius-us"
  }
}

resource "aws_instance" "web4" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t3.micro"
  key_name = "pair_key_vinicius_us" # key chave publica cadastrada na AWS 
  subnet_id               =  aws_subnet.my_subnet4.id # vincula a subnet direto e gera o IP automático
  #private_ip              = "10.80.0.1"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  vpc_security_group_ids  = [
    "${aws_security_group.allow_ssh_terraform.id}",
  ]

  tags = {
    Name = "ec2-4-vinicius-us"
  }
}
#resource "aws_eip" "example" {
#  vpc = true
#}

#resource "aws_eip_association" "eip_assoc" {
#  instance_id   = aws_instance.web.id
#  allocation_id = aws_eip.example.id
#}

# terraform refresh para mostrar o ssh

#output "aws_instance_e_ssh" {
#  value = [
#    aws_instance.web.public_ip,
#    "ssh -i ~/Desktop/devops/treinamentoItau ubuntu@${aws_instance.web.public_dns}"
#  ]
#}
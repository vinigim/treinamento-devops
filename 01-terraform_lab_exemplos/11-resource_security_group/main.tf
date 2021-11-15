provider "aws" {
<<<<<<< HEAD
  region = "sa-east-1"
}

resource "aws_instance" "web" {
  subnet_id     = "subnet-048155f5678ed3564"
  ami= "ami-07c267c1d2395046a"
  instance_type = "t2.micro"
  key_name = "key_pair_dev_01"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-vinicius-tf2"
  }
    vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
}
output "instance_public_dns" {
  value = [
    aws_instance.web.public_dns, 
    aws_instance.web.public_ip,
    aws_instance.web.private_ip,
    "ssh -i C:/Users/vigim/.ssh/id_rsa_dev ubuntu@${aws_instance.web.public_ip}"
  ]
  description = "Mostra o DNS e os IPs publicos e privados da maquina criada."
=======
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name = "treinamento-turma1_itau" # Nome da Key gerada pelo ssk-keygem e upada na AWS
  tags = {
    Name = "Minha Maquina Simples EC2"
  }
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
>>>>>>> ccb2fe85ec0b45127922c8e264a0a31d71f77830
}
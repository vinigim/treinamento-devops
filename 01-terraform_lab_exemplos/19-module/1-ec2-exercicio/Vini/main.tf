provider "aws" {
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
    vpc_security_group_ids  = [
    aws_security_group.allow_ssh_terraform.id,
  ]

  tags = {
    Name = "EC2-vinicius-module"
  }
}
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  # subnet_id     = "subnet-048155f5678ed3564"
  subnet_id = "${aws_subnet.my_subnet_c_priv.id}"
  # ami= "ami-07c267c1d2395046a"
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t3.large"
  key_name = "pair_key_vini_desafio"
  # associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.allow_ssh_priv.id}"]
  root_block_device {
    encrypted = true
    volume_size = 110
  }
  tags = {
    Name = "ec2-vini-priv-desafio"
  }
}



resource "aws_key_pair" "chave_key" {
  key_name   = "pair_key_vini_desafio"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDVSGLBP1GgEyL6A4JHRikg3Grd7gA5InwfrCZVbD0c4MecVsPDqlkLbCHQZPbK9hbuQLf7WZecTgI6TxaiUQHMCWe2BfK0e4Ps8yLHL4aFLPD856xBUGzRI8psj+b3fZn4aerbB0Vd/Y5UYbWpE2Ye6AwOUAPuZKaAjWlhddHPx0uexxj43LI1OGz6p43OyQe0xGBcjrpWVFsGSSZOBXkkkITIOf4fgpyqLXq6JzSkbi2qV4UiyiwgJSAmEuJJHSEu9EGGC44KVbrM/ZO7be9CBNG48tH8q29eFPuPxeTCrziwz4hFfA6HCQblrm8gGZ/uuVHh38fpQ4qpUTe3UZ6U9OEqtFn5r4u+cUVBkYiDWZwAhXijlEPYXW/TXShSmQxHr5BGFgaTtF4fwk5+IIC3FvCayU8U+jUNpqV0/KxFZ2DRkmAVzFAup+kRh+6lbNsgKZsrMrFSrb0mXImg2s98z/EmQl420HI6l2t2HR89h/joVSd/qg1DGMUdApRX9Vk= vigim@DESKTOP-AMMOUD3"
}

output "instance_ip_ami" {
  value = [
    aws_instance.web.public_dns, 
    aws_instance.web.public_ip,
    aws_instance.web.private_ip,
    "${data.aws_ami.ubuntu.id}"
  ]
  description = "Mostra o DNS, os IPs publicos e privados e o AMI da maquina criada."
}

# provider "aws" {
#   region = "us-east-1"
# }

# resource "aws_instance" "web" {
#   ami           = "ami-09e67e426f25ce0d7"
#   instance_type = "t2.micro"
#   subnet_id              = "subnet-eddcdzz4"
#   # availability_zones = ["us-east-1"] # configurando zona para criar maquinas
#   tags = {
#     Name = "Minha Maquina Simples EC2"
#   }
#   volume_id = aws_ebs_volume.itau_volume_encrypted.id
# }


# resource "aws_ebs_volume" "itau_volume_encrypted" {
#   size      = 8
#   encrypted = true
#   tags      = {
#     Name = "Volume itaú"
#   }
# }



##### Caso Itaú #####
# aws configure # maquina pessoal
# nas do itaú colocar as variáveis de ambiente no bashrc
# https://docs.aws.amazon.com/sdkref/latest/guide/environment-variables.html
# configurar via environment variable
# export AWS_ACCESS_KEY_ID=""
# export AWS_SECRET_ACCESS_KEY=""
# export AWS_DEFAULT_REGION=""

# provider "aws" {
#   region = "us-east-1"
# }

# resource "aws_instance" "web" {
#   ami = "ami-09e67e426f25ce0d7"
#   instance_type = "t3.micro"
#   subnet_id = "subnet-05880ea9006199004"
  
#   tags = {
#     Name = "MinhaPrimeiraMaquina-Carol  "
#   }
# }

# resource "aws_ebs_volume" "itau_volume_encrypted" {
#   size      = 8
#   encrypted = true
#   availability_zone = "us-east-1a"
#   tags      = {
#     Name = "Volume itaú"
#   }
# }

# resource "aws_volume_attachment" "ebs_att" {
#   device_name = "/dev/sdh"
#   volume_id   = aws_ebs_volume.itau_volume_encrypted.id
#   instance_id = aws_instance.web.id
# }

# Gamaacademythree-sbx - # passago a chave pelo pessoal de segurança itaú
# export AWS_ACCESS_KEY_ID="3232323232"
# export AWS_SECRET_ACCESS_KEY="34433444sssdd3+ssa/dd434343"

# //////

# ///////// do fernando zerati //////
provider "aws" {
  region = "sa-east-1"
}
<<<<<<< HEAD

resource "aws_instance" "web" {
  subnet_id     = "subnet-048155f5678ed3564"
  ami= "ami-07c267c1d2395046a"
  instance_type = "t2.micro"
  key_name = "chave_key_vini_01"
  associate_public_ip_address = true
=======
resource "aws_instance" "web" {
  subnet_id     = "subnet-05d2f48a5e97f0b1a"
  ami= "ami-054a31f1b3bf90920"
  instance_type = "t2.micro"
>>>>>>> ccb2fe85ec0b45127922c8e264a0a31d71f77830
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
<<<<<<< HEAD
    Name = "ec2-vinicius-tf"
  }
}
resource "aws_key_pair" "chave_key" {
  key_name   = "chave_key_vini_01"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSF0gO/u4lEqDgvZO1H4WlJGynP9RJzPARRuspvOurl2MAvv6LZG+tJiIKjZdcGbGtSYhpy4EHZOdUNRwt8gf1ENlAW0Ao85qm/VXYmv0o5cfcbl1j40pTJDw5JV2M7MEBnTDfs7EytIAOFmsVLdyhTHqqBWT82Q1lZ4ISutO340wH5eyqqgp+AFyihPJPJW4Y3WqYf89GSKSxia3MMgZ0DctPUnB/ssUKF0tkKq43yhn5+P3KXLU/Udca9UXTLe+ehNQnX7kfPWnm445vKEZKRbbv7xnRhNxYdzBbkF0S650zmJHEFUWUZcovA/00LeYC109LRCvby5FruCy3ngc2RdUvUX7qmd7new9oMZVQzCL96A8tMagn0xanUxa86AhU+Yc3HE0YfOYGSQrS7ZYRGI0fC9mIfuhwgf6GCjYswAPVynFC94O4gVv+Zqg9BKQitRiF/ct7p3+NApG9X5/CKJOCtynIkP9xZUwC2KemTME0B1GhSgbdPEKIFoHQle8= ubuntu@ec2-vinicius-large"
}


# https://www.terraform.io/docs/language/values/outputs.html
output "instance_public_dns" {
  value = [
    aws_instance.web.public_dns, 
    aws_instance.web.public_ip,
    aws_instance.web.private_ip,
    "ssh -i C:/Users/vigim/.ssh/id_rsa_dev ubuntu@${aws_instance.web.public_ip}"
  ]
  description = "Mostra o DNS e os IPs publicos e privados da maquina criada."
}
=======
    Name = "ec2-zerati-tf"
  }
}
>>>>>>> ccb2fe85ec0b45127922c8e264a0a31d71f77830
# /////
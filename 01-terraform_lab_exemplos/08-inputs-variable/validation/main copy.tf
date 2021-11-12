variable "security_group" {
  type        = list(string)
  
  description = "Informa o SG da sua máquina:"
}

variable "subnet" {
  type        = string
  description = "Informa o Subnet da sua máquina:"

  validation {
    condition     = substr(var.subnet, 0, 7) == "subnet-"
    error_message = "O valor do subnet não é válido, tem que começar com \"subnet-\"."
  }
}

variable "ami" {
  type        = string
  description = "Informa o AMI da sua máquina:"

  validation {
    condition     = substr(var.ami, 0, 4) == "ami-"
    error_message = "O valor do AMI não é válido, tem que começar com \"AMI-\"."
  }
}

variable "instance_type" {
  type        = string
  description = "Informa o instance type da sua máquina:"

  validation {
    condition     = substr(var.instance_type, 0, 3) == "t2."
    error_message = "O valor do instance type não é válido, tem que começar com \"t2.\"."
  }
}


output "security_group" {
    value = var.security_group
}
output "subnet" {
    value = var.subnet
}
output "ami" {
    value = var.ami
}
output "instance_type" {
    value = var.instance_type
}
provider "aws" {
  region = "sa-east-1"
}
resource "aws_instance" "web" {
  subnet_id     = var.subnet
  ami= var.ami
  instance_type = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids = var.security_group
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-vinicius-tf"
  }
}
output "instance_info" {
  value = [
    subnet_id, 
    ami,
    instance_type,
    "ssh -i C:/Users/vigim/.ssh/id_rsa_dev ubuntu@${aws_instance.web.public_ip}"
  ]
  description = "Mostra o DNS e os IPs publicos e privados da maquina criada."
}
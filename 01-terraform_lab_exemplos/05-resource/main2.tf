provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "web" {
  subnet_id     = "subnet-048155f5678ed3564"
  ami= "ami-07c267c1d2395046a"
  instance_type = "t2.large"
  key_name = "chave_key_vini_02"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  root_block_device {
    encrypted = true
    volume_size = 110
  }
  tags = {
    Name = "ec2-vinicius-nginx-theme"
  }
}



resource "aws_key_pair" "chave_key" {
  key_name   = "chave_key_vini_02"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSF0gO/u4lEqDgvZO1H4WlJGynP9RJzPARRuspvOurl2MAvv6LZG+tJiIKjZdcGbGtSYhpy4EHZOdUNRwt8gf1ENlAW0Ao85qm/VXYmv0o5cfcbl1j40pTJDw5JV2M7MEBnTDfs7EytIAOFmsVLdyhTHqqBWT82Q1lZ4ISutO340wH5eyqqgp+AFyihPJPJW4Y3WqYf89GSKSxia3MMgZ0DctPUnB/ssUKF0tkKq43yhn5+P3KXLU/Udca9UXTLe+ehNQnX7kfPWnm445vKEZKRbbv7xnRhNxYdzBbkF0S650zmJHEFUWUZcovA/00LeYC109LRCvby5FruCy3ngc2RdUvUX7qmd7new9oMZVQzCL96A8tMagn0xanUxa86AhU+Yc3HE0YfOYGSQrS7ZYRGI0fC9mIfuhwgf6GCjYswAPVynFC94O4gVv+Zqg9BKQitRiF/ct7p3+NApG9X5/CKJOCtynIkP9xZUwC2KemTME0B1GhSgbdPEKIFoHQle8= ubuntu@ec2-vinicius-large"
}

output "instance_public_dns" {
  value = [
    aws_instance.web.public_dns, 
    aws_instance.web.public_ip,
    aws_instance.web.private_ip,
  ]
  description = "Mostra o DNS e os IPs publicos e privados da maquina criada."
}
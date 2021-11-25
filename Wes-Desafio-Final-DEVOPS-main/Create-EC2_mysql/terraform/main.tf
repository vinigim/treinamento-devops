provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "mysql_dev" {
  ami           = var.image_id
  instance_type = "t3.medium"
  subnet_id     = var.subnet_priv_1
  key_name = "chave_key_vini_06" # Nome da Key gerada pelo ssk-keygem e upada na AWS
  associate_public_ip_address = false
  tags = {
    Name = "vini_mysql_dev",
    Itau = true
  }
  vpc_security_group_ids = [aws_security_group.mysql.id]
}

resource "aws_instance" "mysql_stage" {
  ami           = var.image_id
  instance_type = "t3.medium"
  subnet_id     = var.subnet_priv_2
  key_name = "chave_key_vini_06" # Nome da Key gerada pelo ssk-keygem e upada na AWS
  associate_public_ip_address = false
  tags = {
    Name = "vini_mysql_stage",
    Itau = true
  }
  vpc_security_group_ids = [aws_security_group.mysql.id]
}

resource "aws_instance" "mysql_prod" {
  ami           = var.image_id
  instance_type = "t3.medium"
  subnet_id     = var.subnet_priv_3
  key_name = "chave_key_vini_06" # Nome da Key gerada pelo ssk-keygem e upada na AWS
  associate_public_ip_address = false
  tags = {
    Name = "vini_mysql_prod",
    Itau = true
  }
  vpc_security_group_ids = [aws_security_group.mysql.id]
}
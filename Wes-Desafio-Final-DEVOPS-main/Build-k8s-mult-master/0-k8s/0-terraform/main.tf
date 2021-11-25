provider "aws" {
  region = "sa-east-1"
}

locals {
  subs = concat([aws_subnet.vini_sub_tf_public_0.id], [aws_subnet.vini_sub_tf_public_1.id], [aws_subnet.vini_sub_tf_public_2.id])
}

resource "aws_instance" "k8s_proxy" {
  ami = var.image_id
  depends_on = [
    aws_subnet.vini_sub_tf_public_0, aws_subnet.vini_sub_tf_public_1
  ]
  instance_type               = "t3.medium"
  key_name                    = "chave_key_vini_06"
  subnet_id                   = element(local.subs, count.index)
  associate_public_ip_address = true
  count                       = 1
  tags = {
    Name = "vini-k8s-haproxy"
  }
  vpc_security_group_ids = [aws_security_group.acessos_workers_vini.id]
}


resource "aws_instance" "k8s_masters" {
  ami = var.image_id
  depends_on = [
    aws_subnet.vini_sub_tf_public_0, aws_subnet.vini_sub_tf_public_1, aws_instance.k8s_workers
  ]
  instance_type               = "t3.large"
  key_name                    = "chave_key_vini_06"
  count                       = 3
  subnet_id                   = element(local.subs, count.index)
  associate_public_ip_address = true
  tags = {
    Name = "vini-k8s-master-${count.index}"
  }
  vpc_security_group_ids = [aws_security_group.acessos_master.id]
}

resource "aws_instance" "k8s_workers" {
  ami = var.image_id
  depends_on = [
    aws_subnet.vini_sub_tf_public_0, aws_subnet.vini_sub_tf_public_1
  ]
  instance_type               = "t3.medium"
  key_name                    = "chave_key_vini_06"
  count                       = 3
  subnet_id                   = element(local.subs, count.index)
  associate_public_ip_address = true
  tags = {
    Name = "vini-k8s_workers-${count.index}"
  }
  vpc_security_group_ids = [aws_security_group.acessos_workers_vini.id]
}

output "k8s-masters" {
  value = [
    for key, item in aws_instance.k8s_masters :
    "k8s-master ${key + 1} - ${item.private_ip} - ssh -i ~/.ssh/id_rsa -o ServerAliveInterval=60 -o StrictHostKeyChecking=no ubuntu@${item.public_dns} "
  ]
}

output "output-k8s_workers" {
  value = [
    for key, item in aws_instance.k8s_workers :
    "k8s-workers ${key + 1} - ${item.private_ip} - ssh -i ~/.ssh/id_rsa -o ServerAliveInterval=60 -o StrictHostKeyChecking=no ubuntu@${item.public_dns} "
  ]
}

output "output-k8s_proxy" {
  value = [
    for key, item in aws_instance.k8s_proxy :
    "k8s-proxy ${key + 1} - ${item.private_ip} - ssh -i ~/.ssh/id_rsa -o ServerAliveInterval=60 -o StrictHostKeyChecking=no ubuntu@${item.public_dns} "
  ]
}

output "security-group-workers-e-haproxy" {
  value = aws_security_group.acessos_workers_vini.id
}

output "security-group-master" {
  value = aws_security_group.acessos_master.id
}

output "subnet_public_0" {
  value = aws_subnet.vini_sub_tf_public_0.id
}

output "subnet_public_1" {
  value = aws_subnet.vini_sub_tf_public_1.id
}

output "subnet_public_2" {
  value = aws_subnet.vini_sub_tf_public_1.id
}

output "subnet_priv_0" {
  value = aws_subnet.vini_sub_tf_priv_0.id
}

output "subnet_priv_1" {
  value = aws_subnet.vini_sub_tf_priv_1.id
}

output "subnet_priv_2" {
  value = aws_subnet.vini_sub_tf_priv_2.id
}
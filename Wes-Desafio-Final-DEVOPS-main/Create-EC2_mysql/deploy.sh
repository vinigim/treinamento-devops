#!/bin/bash

cd Wes-Desafio-Final-DEVOPS-main/Create-EC2_mysql/terraform
terraform init
TF_VAR_image_id=$image_id TF_VAR_subnet_priv_1=$subnet_priv_1 TF_VAR_subnet_priv_2=$subnet_priv_2 TF_VAR_subnet_priv_3=$subnet_priv_3 TF_VAR_sg_workers=$sg_workers terraform apply -auto-approve

echo  "Aguardando a criação das maquinas ..."
sleep 60

ID_DEV=$(terraform output | grep "mysql_dev -" | awk '{print $3}')
ID_STAGE=$(terraform output | grep "mysql_stage -" | awk '{print $3}')
ID_PROD=$(terraform output | grep "mysql_prod -" | awk '{print $3}')


echo "
[ec2-mysql-dev]
$ID_DEV
[ec2-mysql-stage]
$ID_STAGE
[ec2-mysql-prod]
$ID_PROD
" > ../ansible/hosts
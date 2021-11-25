#!/bin/bash

cd Create-EC2_mysql/terraform
terraform init
TF_VAR_image_id=$image_id TF_VAR_subnet_priv_1=$subnet_priv_1 TF_VAR_subnet_priv_2=$subnet_priv_2 TF_VAR_subnet_priv_3=$subnet_priv_3 TF_VAR_sg_workers=$sg_workers terraform destroy -auto-approve
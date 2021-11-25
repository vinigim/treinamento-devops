#!/bin/bash

cd Wes-Desafio-Final-DEVOPS-main/Build-k8s-mult-master/Build-k8s-mult-master/0-k8s/0-terraform
TF_VAR_image_id=$image_id terraform destroy -auto-approve

#!/bin/bash
cd Wes-Desafio-Final-DEVOPS-main/Build-k8s-mult-master/0-k8s/2-ansible/01-k8s-install-masters_e_workers
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts 2-provisionar-k8s-master-auto-shell.yml -u ubuntu --private-key /var/lib/jenkins/.ssh/id_rsa
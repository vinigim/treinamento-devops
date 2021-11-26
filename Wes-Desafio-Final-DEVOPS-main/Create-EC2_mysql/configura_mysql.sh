#!/bin/bash
cd Wes-Desafio-Final-DEVOPS-main/Create-EC2_mysql/ansible
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts mysql.yml -u ubuntu --private-key /var/lib/jenkins/.ssh/id_rsa
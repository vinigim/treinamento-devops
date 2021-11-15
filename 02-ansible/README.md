 ansible-playbook -i hosts inicio.yml -u ubuntu --private-key /home/ubuntu/.ssh/id_rsa

ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key /home/ubuntu/.ssh/id_rsa

 ssh -i ../../"chave_key_vini_01" ubuntu@ec2-18-230-60-116.sa-east-1.compute.amazonaws.com
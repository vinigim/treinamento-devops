<<<<<<< HEAD
 ansible-playbook -i hosts inicio.yml -u ubuntu --private-key /home/ubuntu/.ssh/id_rsa

ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key /home/ubuntu/.ssh/id_rsa

 ssh -i ../../"chave_key_vini_01" ubuntu@ec2-18-230-60-116.sa-east-1.compute.amazonaws.com
=======
 ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ../../id_rsa_itau_treinamento

 ssh -i ../../id_rsa_itau_treinamento ubuntu@ec2-3-93-240-108.compute-1.amazonaws.com
>>>>>>> ccb2fe85ec0b45127922c8e264a0a31d71f77830

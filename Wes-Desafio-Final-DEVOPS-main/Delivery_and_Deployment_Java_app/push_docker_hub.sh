cd Wes-Desafio-Final-DEVOPS-main
tag=$(git describe --tags $(git rev-list --tags --max-count=1))

sudo docker tag vinigim/crud-java-login:$tag hub.docker.com/r/vinigim/crud-java-login:$tag
sudo docker push vinigim/crud-java-login:$tag
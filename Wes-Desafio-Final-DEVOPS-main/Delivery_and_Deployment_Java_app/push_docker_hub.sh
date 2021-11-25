tag=$(git describe --tags $(git rev-list --tags --max-count=1))

sudo docker tag weslleyf/crud-java-login:$tag hub.docker.com/r/weslleyf/crud-java-login:$tag
sudo docker push weslleyf/crud-java-login:$tag
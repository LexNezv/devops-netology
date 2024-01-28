docker rm $(docker ps -aq)
docker run -d --name=centos7 centos:7 sleep 600
docker run -d --name=ubuntu python:3.11 sleep 600
docker run -d --name=fedora fedora:37 sleep 600
ansible-playbook -i inventory site.yml --ask-vault-pass
docker kill $(docker ps -q)
docker rm $(docker ps -aq)
run:
	ansible-playbook site.yml -u vagrant -kK -D
pullRole:
	ansible-galaxy install -r requirements.yml -p ./roles
upDocker:
	docker run -d -it --rm=false --name=test-01 ubuntu:latest
connectDocker:
	docker exec -it test-01 bash
testDocker:
	ansible-playbook testDocker.yml
pullRole:
	ansible-galaxy install -r requirements.yml -p ./roles
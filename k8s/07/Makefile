NAMESPACE=test
get:
	echo "===============================================================ALL=====" ; \
	kubectl -n $(NAMESPACE) get all; \
	echo "================================================================PV=====" ; \
	kubectl -n $(NAMESPACE) get pv; \
	echo "================================================================PVC=====" ; \
        kubectl -n $(NAMESPACE) get pvc; \
	echo "========================================================VOLUMES_DESCRIBE====="; \
	kubectl -n $(NAMESPACE) describe pv,pvc
apply:
	kubectl apply -n $(NAMESPACE) -f volumes.yml; \
	kubectl apply -n $(NAMESPACE) -f deploy.yml,service.yml,ingress.yml
delete:
	kubectl delete -n $(NAMESPACE) -f deploy.yml,service.yml,ingress.yml,volumes.yml


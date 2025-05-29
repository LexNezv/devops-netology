openssl genrsa -out user.key 2048
openssl req -new -key user.key -out user.csr -subj "/CN=Alex"
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: Alex-csr
spec:
  request: $(cat user.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400  # 1 день (можно увеличить)
  usages:
  - client auth
EOF
kubectl get csr
kubectl certificate approve Alex-csr
kubectl get csr Alex-csr -o jsonpath='{.status.certificate}' | base64 -d > user.crt

kubectl config set-credentials Alex \
  --client-key=user.key \
  --client-certificate=user.crt \
  --embed-certs=true

kubectl config set-context Alex-context \
  --cluster=microk8s-cluster \
  --user=Alex \

kubectl config use-context Alex-context
kubectl get pods
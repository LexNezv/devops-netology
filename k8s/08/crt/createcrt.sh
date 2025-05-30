CSRNAME=$(date +%s)alex
echo $CSRNAME
openssl genrsa -out user.key 2048
openssl req -new -key user.key -out user.csr -subj "/CN=alex"
# или если нам еще нужны группы -subj "/CN=alex/O=$group1/O=$group2/O=$group3"
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: $CSRNAME
spec:
  request: $(cat user.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400  # 1 день (можно увеличить)
  usages:
  - client auth
EOF
kubectl get csr
kubectl certificate approve $CSRNAME
kubectl get csr $CSRNAME -o jsonpath='{.status.certificate}' | base64 -d > user.crt
openssl x509 -in user.crt -text -noout | grep "Subject:"

kubectl config set-credentials alex \
  --client-key=user.key \
  --client-certificate=user.crt \
  --embed-certs=true

kubectl config set-context alex-context \
  --cluster=microk8s-cluster \
  --user=alex \

kubectl config use-context alex-context
kubectl config current-context
kubectl get pods

# Хеши должны быть одинаковые
openssl x509 -noout -modulus -in user.crt | openssl md5
openssl rsa -noout -modulus -in user.key | openssl md5
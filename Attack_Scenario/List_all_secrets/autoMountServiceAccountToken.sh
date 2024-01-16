# install kubectl command in pod
curl -LO https://dl.k8s.io/release/v1.28.4/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/bin/kubectl

APISERVER=https://kubernetes.default.svc

# 서비스어카운트(ServiceAccount) 토큰 경로
SERVICEACCOUNT=/var/run/secrets/kubernetes.io/serviceaccount

# 이 파드의 네임스페이스를 읽는다
NAMESPACE=$(cat ${SERVICEACCOUNT}/namespace)

# 서비스어카운트 베어러 토큰을 읽는다
TOKEN=$(cat ${SERVICEACCOUNT}/token)

# 내부 인증 기관(CA)을 참조한다
CACERT=${SERVICEACCOUNT}/ca.crt

kubectl config set-cluster cfc --server=https://kubernetes.default --certificate-authority=${CACERT}
kubectl config set-context cfc --cluster=cfc
kubectl config set-credentials user --token=${TOKEN}
kubectl config set-context cfc --user=user
kubectl config use-context cfc
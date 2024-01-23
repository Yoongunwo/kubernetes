helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

helm pull prometheus-community/kube-prometheus-stack --untar

cd kube-prometheus-stack

# vim values.yaml -> adminPassword: <password>

helm install prometheus . -n monitoring -f values.yaml

# kubectl edit service -n monitoring prometheus-kube-prometheus-prometheus -> type: LoadBalancer
# kubectl edit service -n monitoring prometheus-grafana -> type: LoadBalancer
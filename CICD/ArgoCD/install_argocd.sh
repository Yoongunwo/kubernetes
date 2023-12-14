# Create argocd Namespace
kubectl apply -f ./argocd.yaml

# install argocd - stable version
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
git clone https://github.com/scriptcamp/kubernetes-jenkins

kubectl create namespace devops-tools

# get password
kubectl exec -it [podID] cat /var/jenkins_home/secrets/initialAdminPassword -n devops-tools
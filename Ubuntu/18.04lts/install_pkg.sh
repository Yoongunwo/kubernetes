#!/usr/bin/env bash

# Install packages
sudo apt-get update -y
sudo apt-get install -y vim git

# Install Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl enable --now docker

# Install Kubernetes
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable --now kubelet

# # Git clone _Book_k8sInfra.git
# if [ "$2" = "Main" ]; then
#   git clone https://github.com/Yoongunwo/kubernetes.git
#   mv /home/vagrant/kubernetes $HOME
#   find $HOME/kubernetes/ -regex ".*\.\(sh\)" -exec chmod 700 {} \;
# fi

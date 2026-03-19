#!/usr/bin/env bash

# Go download and setup
curl -O https://dl.google.com/go/go1.21.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc

# Unknown service runtime.v1alpha2.RuntimeService error troubleshooting
sudo sed -i '/^disabled_plugins = \["cri"\]/s/^/#/' /etc/containerd/config.toml
sudo systemctl restart containerd

# Init Kubernetes using containerd
sudo kubeadm init --apiserver-advertise-address=10.125.37.130 \
--token 123456.1234567890123456 --token-ttl 0 \
--pod-network-cidr=172.16.0.0/16 

# Config for master node only  
sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Config for Kubernetes network using Calico
kubectl create -f https://raw.githubusercontent.com/yoongunwo/kubernetes/main/Calico/setup/tigera-operator.yaml
kubectl create -f https://raw.githubusercontent.com/yoongunwo/kubernetes/main/Calico/setup/custom-resources.yaml

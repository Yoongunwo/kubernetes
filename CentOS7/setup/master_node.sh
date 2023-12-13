#!/usr/bin/env bash

# go download
curl -O https://dl.google.com/go/go1.21.5.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
echo 'export GOPATH=$HOME/go' >> ~/.bash_profile
echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bash_profile
source ~/.bash_profile

# init kubernetes 
kubeadm init --apiserver-advertise-address=192.168.1.10 \
--pod-network-cidr=172.16.0.0/16 --cri-socket=/var/run/crio/crio.sock

# config for master node only  
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# config for kubernetes's network 
kubectl apply -f \
https://raw.githubusercontent.com/yoongunwo/kubernetes/Calico/setup/tigera-operator.yaml

kubectl apply -f \
https://raw.githubusercontent.com/yoongunwo/kubernetes/Calico/setup/tigera-operator.yaml

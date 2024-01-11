#!/usr/bin/env bash

# go download
curl -O https://dl.google.com/go/go1.21.5.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
echo 'export GOPATH=$HOME/go' >> ~/.bash_profile
echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bash_profile
source ~/.bash_profile

sed -i 's/192.168.1.10/192.168.1.11/g' admin.conf

# init kubernetes 
kubeadm init --apiserver-advertise-address=192.168.1.11 \
--token 123456.1234567890123456 --token-ttl 0 \
--pod-network-cidr=172.17.0.0/16 --cri-socket=/var/run/crio/crio.sock

# config for master node only  
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# config for kubernetes's network 
kubectl create -f \
https://raw.githubusercontent.com/yoongunwo/kubernetes/main/Calico/setup/tigera-operator.yaml

kubectl create -f \
https://raw.githubusercontent.com/yoongunwo/kubernetes/main/Calico/setup/custom-resources.yaml

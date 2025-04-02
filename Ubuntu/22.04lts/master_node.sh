#!/usr/bin/env bash

# go download
curl -O https://dl.google.com/go/go1.21.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
echo 'export GOPATH=$HOME/go' >> ~/.bash_profile
echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bash_profile
source ~/.bash_profile

# unknown service runtime.v1alpha2.RuntimeService error troubleshooting
# sudo sed -i '/^disabled_plugins = \["cri"\]/s/^/#/' /etc/containerd/config.toml
# sudo systemctl restart containerd

containerd config default | tee /etc/containerd/config.toml
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml  
sudo systemctl restart containerd

# init kubernetes using containerd
sudo kubeadm init --apiserver-advertise-address=10.125.37.77 \
--token 123456.1234567890123456 --token-ttl 0 \
--pod-network-cidr=172.16.0.0/16

# config for master node only  
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

strace -eopenat kubectl version

# config for kubernetes's network 
kubectl create -f \
https://raw.githubusercontent.com/yoongunwo/kubernetes/main/Calico/setup/tigera-operator.yaml

kubectl create -f \
https://raw.githubusercontent.com/yoongunwo/kubernetes/main/Calico/setup/custom-resources.yaml

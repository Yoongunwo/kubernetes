#!/usr/bin/env bash

# install packages 
yum install epel-release -y
yum install vim-enhanced -y
yum install git -y

# install docker 
yum install docker -y && systemctl enable --now docker

# install kubernetes cluster 
#yum -y install git wget curl
#yum install -y yum-utils
#yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#yum -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#systemctl enable --now docker

# install cri-dockerd 
OS=CentOS_7
VERSION=1.28
curl -L -o /etc/yum.repos.d/devel:kubic:libcontainers:stable.repo https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/${OS}/devel:kubic:libcontainers:stable.repo
curl -L -o /etc/yum.repos.d/devel:kubic:libcontainers:stable:cri-o:${VERSION}.repo https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:${VERSION}/CentOS_7/devel:kubic:libcontainers:stable:cri-o:${VERSION}.repo

yum install -y cri-o cri-tools
systemctl enable --now crio

# install kubernetes cluster 
yum install -y kubelet-$1 kubeadm-$1 --disableexcludes=kubernetes
curl -LO https://dl.k8s.io/release/v1.28.4/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/bin/kubectl

systemctl enable --now kubelet
##

# git clone _Book_k8sInfra.git 
if [ $2 = 'Main' ]; then
  git clone https://github.com/sysnet4admin/_Book_k8sInfra.git
  git clone https://github.com/Yoongunwo/kubernetes.git
  mv /home/vagrant/_Book_k8sInfra $HOME
  find $HOME/_Book_k8sInfra/ -regex ".*\.\(sh\)" -exec chmod 700 {} \;
fi
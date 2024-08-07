#!/usr/bin/env bash

# 패키지 업데이트 및 필수 패키지 설치
sudo apt-get update -y
sudo apt-get install -y vim git curl

# Docker 설치
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Docker 서비스 활성화 및 시작
sudo systemctl enable --now docker

# Kubernetes 설치
# VERSION=$1
sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Kubelet 서비스 활성화 및 시작
sudo systemctl enable --now kubelet

# GitHub 리포지토리 클론
if [ "$2" = 'Main' ]; then
  git clone https://github.com/Yoongunwo/kubernetes.git
  mv kubernetes $HOME
  find $HOME/kubernetes/ -regex ".*\.\(sh\)" -exec chmod 700 {} \;
fi

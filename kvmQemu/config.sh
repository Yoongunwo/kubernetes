#!/usr/bin/env bash

# vim configuration 
echo 'alias vi=vim' >> /etc/profile

# swapoff -a to disable swapping
sudo swapoff -a
# sed to comment the swap partition in /etc/fstab
sed -i.bak -r 's/(.+ swap .+)/#\1/' /etc/fstab

# Kubernetes repo 설정
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

sudo mkdir -p /etc/apt/keyrings
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# 방화벽 비활성화 (Ubuntu에서는 ufw 사용)
sudo ufw disable

# 필요한 커널 모듈 및 sysctl 설정
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system

# 필요한 커널 모듈 로드
sudo modprobe br_netfilter

# 로컬 DNS 설정 (Vagrant가 셸 코드를 전달할 수 없음)
echo "10.125.37.128 m-k8s" | sudo tee -a /etc/hosts
for (( i=1; i<=$1; i++ )); do echo "192.168.1.10$i w$i-k8s" | sudo tee -a /etc/hosts; done

# DNS 설정
cat <<EOF | sudo tee /etc/resolv.conf
nameserver 1.1.1.1 # Cloudflare DNS
nameserver 8.8.8.8 # Google DNS
EOF

# SELinux 설정 (Ubuntu에서는 기본적으로 사용하지 않음, 필요시 설치)
# sudo apt-get install -y selinux-utils
# sudo setenforce 0
# sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

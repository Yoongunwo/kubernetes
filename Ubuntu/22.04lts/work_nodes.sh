#!/usr/bin/env bash

# unknown service runtime.v1alpha2.RuntimeService error troubleshooting
# sudo sed -i '/^disabled_plugins = \["cri"\]/s/^/#/' /etc/containerd/config.toml
# sudo systemctl restart containerd

containerd config default | tee /etc/containerd/config.toml
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml
sudo systemctl restart containerd

kubeadm join 10.125.37.77:6443 --token 123456.1234567890123456 \
        --discovery-token-ca-cert-hash sha256:47135b2d0215477128a6cf53f9e1e23407033c118c153364aa933bb04664cf2c

# 워커 노드 설정
sudo kubeadm join --token 123456.1234567890123456 \
  --discovery-token-unsafe-skip-ca-verification 10.125.37.77:6443

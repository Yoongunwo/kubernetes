#!/usr/bin/env bash

# unknown service runtime.v1alpha2.RuntimeService error troubleshooting
sed -i '/^disabled_plugins = \["cri"\]/s/^/#/' /etc/containerd/config.toml
sudo systemctl restart containerd


# config for work_nodes only 
kubeadm join --token 123456.1234567890123456 \
        --discovery-token-unsafe-skip-ca-verification 192.168.1.10:6443
        
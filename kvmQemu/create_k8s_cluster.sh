#!/bin/bash

# 설정
NUM_WORKERS=3
MASTER_NAME="m-k8s"
WORKER_PREFIX="w"
ISO_PATH="/home/yoon/Downloads/ubuntu-20.04.6-live-server-amd64.iso"
BRIDGE_NETWORK="br0"

# 마스터 노드 생성
sudo virt-install --name=$MASTER_NAME \
  --vcpus=4 \
  --memory=5120 \
  --disk size=20 \
  --network bridge=$BRIDGE_NETWORK \
  --graphics none \
  --os-type=linux \
  --os-variant=ubuntu20.04 \
  --location=$ISO_PATH \
  --extra-args="console=ttyS0" \
  --noautoconsole

# 워커 노드 생성
for i in $(seq 1 $NUM_WORKERS); do
  sudo virt-install --name="${WORKER_PREFIX}-${i}" \
    --vcpus=2 \
    --memory=5120 \
    --disk size=20 \
    --network bridge=$BRIDGE_NETWORK \
    --graphics none \
    --os-type=linux \
    --os-variant=ubuntu20.04 \
    --location=$ISO_PATH \
    --extra-args="console=ttyS0" \
    --noautoconsole
done

# VM이 완전히 부팅될 때까지 대기
sleep 300

# 각 VM에 스크립트 복사 및 실행
for vm in $MASTER_NAME $(seq -f "${WORKER_PREFIX}-%g" 1 $NUM_WORKERS); do
  # 스크립트 복사
  sudo virt-copy-in -d $vm install_pkg.sh config.sh /tmp/
  
  # 스크립트 실행
  sudo virsh qemu-agent-command $vm '{"execute":"guest-exec", "arguments":{"path":"/bin/bash", "args":["-c", "chmod +x /tmp/install_pkg.sh /tmp/config.sh && /tmp/install_pkg.sh && /tmp/config.sh '$NUM_WORKERS'"]}}' --timeout 10

  if [ "$vm" = "$MASTER_NAME" ]; then
    sudo virt-copy-in -d $vm master_node.sh /tmp/
    sudo virsh qemu-agent-command $vm '{"execute":"guest-exec", "arguments":{"path":"/bin/bash", "args":["-c", "chmod +x /tmp/master_node.sh && /tmp/master_node.sh"]}}' --timeout 10
  else
    sudo virt-copy-in -d $vm work_nodes.sh /tmp/
    sudo virsh qemu-agent-command $vm '{"execute":"guest-exec", "arguments":{"path":"/bin/bash", "args":["-c", "chmod +x /tmp/work_nodes.sh && /tmp/work_nodes.sh"]}}' --timeout 10
  fi
done
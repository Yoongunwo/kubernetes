# 쿠버네티스 1.24 이전까지는 Service Account 생성 시 자동으로 Service Account Token 생성
# 쿠버네티스 1.24 이후부터는 Service Account 생성 시 자동으로 Service Account Token 생성 안함
# Secret Resource를 통해 Service Account Token 생성

# apiVersion: v1
# kind: Secret
# metadata:
#   name: targetsecret
#   namespace: targetns
#   annotations:
#     kubernetes.io/service-account.name: targetsa
# type: kubernetes.io/service-account-token

# Service Account Secret 요소 : ca.crt, namespace, token

# kubectl get secret -n <namespace>
# kubectl describe pod -n <namespace> <pod_name>
# pod와 service account의 Token이 일치하지 않는 이유
# - 쿠버네티스는 보안상의 이유로 Service Account Token을 자동으로 회전(rotate)함
# - Service Account 이 탈취당하는 경우나 노출되는 경우를 대비하여 보안을 강화하기 위한 조치

# Service Account Token을 사용하여 쿠버네티스 API Server에 접근하는 방법
# 인증 토큰을 api server에 직접 전달하여 kubectl 프록시 사용 피하기

# 내부 API 서버 호스트 이름을 가리킨다
APISERVER=https://kubernetes.default.svc

# 서비스어카운트(ServiceAccount) 토큰 경로
SERVICEACCOUNT=/var/run/secrets/kubernetes.io/serviceaccount

# 이 파드의 네임스페이스를 읽는다
NAMESPACE=$(cat ${SERVICEACCOUNT}/namespace)

# 서비스어카운트 베어러 토큰을 읽는다
TOKEN=$(cat ${SERVICEACCOUNT}/token)

# 내부 인증 기관(CA)을 참조한다
CACERT=${SERVICEACCOUNT}/ca.crt

# TOKEN으로 API를 탐색한다
curl --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -X GET ${APISERVER}/api


# get container ID
# 컨테이너 root 권한 실행
kubectl get pods [podname] -o jsonpath={.status.containerStatuses[].containerID}
runc exec -t -u 0 <ContainerID> sh
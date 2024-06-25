# ref. https://istio.io/latest/docs/setup/getting-started/

# Install Istioctl
curl -L https://istio.io/downloadIstio | sh -
cd istio-version


export PATH=$PWD/bin:$PATH
# or
$ vi ~/.bashrc
...
export PATH=$PATH:$HOME/istio-1.19.3/bin
...

$ source ~/.bashrc

# Install Istio
istioctl install --set profile=demo -y

# add a namespace label to instruct Istio to automatically inject Envoy sidecar proxies when you deploy your application later
kubectl label namespace default istio-injection=enabled

# deploy the sample application
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml

# confirm the application is running
kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"

# create a gateway for the application
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml


## 이후는 ref 참조

kubectl apply -f - <<EOF
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: "default"
  namespace: "istio-system"
spec:
  mtls:
    mode: STRICT
EOF


kubectl apply -f - <<EOF
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: allow-nothing
  namespace: default
spec:
  {}
EOF


kubectl apply -f - <<EOF
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: "productpage-viewer"
  namespace: default
spec:
  selector:
    matchLabels:
      app: productpage
  action: ALLOW
  rules:
  - to:
    - operation:
        methods: ["GET"]
EOF



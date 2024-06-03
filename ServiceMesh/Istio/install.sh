# https://istio.io/latest/docs/setup/getting-started/

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
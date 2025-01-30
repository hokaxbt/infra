# Initialize Cluster

Create new load balancer:

```shell
hcloud load-balancer create --name kubernetes --type lb11 --algorithm-type round_robin --location fsn1
```

Attach first control plane node to load balancer using the following command:

```shell
hcloud load-balancer add-service kubernetes --protocol tcp --listen-port 6443 --destination-port 6443
hcloud load-balancer add-target kubernetes --server controller-1
```

SSH to `controller-1` and create the kubeadm config:

```shell
cat <<EOF | tee /root/kubeadm.yaml
apiVersion: kubeadm.k8s.io/v1beta4
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: <controller-1-ip>
  bindPort: 6443
---
apiVersion: kubeadm.k8s.io/v1beta4
kind: ClusterConfiguration
networking:
  serviceSubnet: 10.96.0.0/12
  podSubnet: 192.168.0.0/16
  dnsDomain: cluster.local
controlPlaneEndpoint: <load-balancer-ip>:6443
apiServer:
  certSANs:
    - "<load-balancer-ip>"
clusterName: "hokaxbt"
---
apiVersion: kubeproxy.config.k8s.io/v1alpha1
kind: KubeProxyConfiguration
mode: iptables
EOF
```

Update config with the `controller-1` and load balancer IP address.

Then initialize the cluster:

```shell
kubeadm init --config ./kubeadm.yaml --upload-certs
```

SSH to all control plane and worker nodes then execute the join command.

## Attach Control Planes to Load Balancer

```shell
hcloud load-balancer add-target kubernetes --server controller-2
hcloud load-balancer add-target kubernetes --server controller-3
```

## Access Cluster

Download the config from `node-1` using the following command:

```shell
scp controller-1:/etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Then add new context in `.kube/config`, replace `kubernetes-admin` username with
`hokaxbt-admin`.

## Install Calico

Install Calico operator:

```shell
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/tigera-operator.yaml
```

Create new calico installation config:

```shell
cat <<EOF | tee calico.yaml
apiVersion: operator.tigera.io/v1
kind: Installation
metadata:
  name: default
spec:
  calicoNetwork:
    nodeAddressAutodetectionV4:
      kubernetes: NodeInternalIP
    ipPools:
      - name: ipv4-pool
        blockSize: 26
        cidr: 192.168.0.0/16
        encapsulation: VXLANCrossSubnet
        natOutgoing: Enabled
        nodeSelector: all()
    mtu: 1440
EOF
```

Install Calico:

```shell
kubectl apply -f calico.yaml
```

Enable Wireguard:

```shell
kubectl patch felixconfiguration default --type='merge' -p '{"spec":{"wireguardEnabled":true}}'
```

Check pods make sure its running:

```shell
kubectl -n calico-system get pods
```

All nodes should be Ready now.

Check DNS using the following command:

```shell
kubectl run -i -t busybox --rm --image=busybox:latest --restart=Never -- nslookup kubernetes.default.svc.cluster.local
kubectl run -i -t busybox --rm --image=busybox:latest --restart=Never -- nslookup google.com
```

## Install Storage Plugin

Add OpenEBS repo:

```shell
helm repo add openebs https://openebs.github.io/openebs
helm repo update
```

Install OpenEBS with LVM enabled:

```shell
helm install openebs openebs/openebs \
    --namespace openebs \
    --create-namespace \
    --set engines.local.lvm.enabled=true \
    --set engines.local.zfs.enabled=false \
    --set engines.replicated.mayastor.enabled=false \
    --set analytics.enabled=false
```

Create storage class:

```shell
kubectl create -f ./config/nvme.yaml
```

Create PVC for testing:

```shell
kubectl create -f ./config/nvme-test.yaml
```

If you run `kubectl get pvc` the status should be bound.

Delete pvc test:

```shell
kubectl delete -f ./config/nvme-test.yaml
```

## Install Ingress

Add `ingress-nginx` repo:

```shell
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```

Install `ingress-nginx`:

```shell
helm install ingress ingress-nginx/ingress-nginx \
    --namespace ingress-nginx \
    --create-namespace \
    --values ./config/ingress-nginx.yaml
```

Make sure `ingress-nginx` pods are scheduled across control plane nodes:

```shell
kubectl get pods -n ingress-nginx -o wide
```

Add load balancer service:

```shell
hcloud load-balancer add-service kubernetes --protocol tcp --listen-port 80 --destination-port 30080
hcloud load-balancer add-service kubernetes --protocol tcp --listen-port 443 --destination-port 30443
```

Make sure the service is healthy before continue next step:

```shell
hcloud load-balancer describe kubernetes
```

## Install Cert Manager

Add Helm repo:

```shell
helm repo add jetstack https://charts.jetstack.io
helm repo update
```

Install `cert-manager`:

```shell
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --values ./config/cert-manager.yaml
```

Create cluster issuer:

```shell
kubectl create -f config/cert-manager-cluster-issuer.yaml
```

Make sure the DNS of `tickerhot.com` is pointed to load balancer IP.

To validate the installation, create service test using the following command:

```shell
kubectl create -f config/cert-manager-test.yaml
```

Access `https://cert-manager-test.tickerhot.com`.

If you need to uninstall, run the following command:

```shell
helm -n cert-manager uninstall cert-manager
```

## Install Metrics Server

Add repo:

```shell
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
```

Install:

```shell
helm install metrics-server metrics-server/metrics-server \
  --namespace metrics-server \
  --create-namespace \
  --set replicas=3 \
  --set apiService.insecureSkipTLSVerify=false \
  --set tls.type="cert-manager"
```

## Resources

-   [flannel](https://github.com/flannel-io/flannel)
-   [OpenEBS Documentation](https://openebs.io/docs/)
-   [Ingress NGINX Controller Documentation](https://kubernetes.github.io/ingress-nginx/)
-   [Cert Manager Documentation](https://cert-manager.io/docs/)
-   [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)
-   [Install Grafana Loki with Helm](https://grafana.com/docs/loki/next/setup/install/helm/)
-   [Deploy Mimir with Helm](https://grafana.com/docs/mimir/latest/set-up/helm-chart/)

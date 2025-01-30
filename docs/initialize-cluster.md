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
---
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
serverTLSBootstrap: true
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

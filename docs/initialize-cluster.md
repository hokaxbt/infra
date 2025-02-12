# Initialize Cluster

SSH to `controller` and create new `kubeadm.yaml` file with the following
content:

```shell
cat <<EOF | tee /root/kubeadm.yaml
apiVersion: kubeadm.k8s.io/v1beta4
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: <controller-ip>
  bindPort: 6443
---
apiVersion: kubeadm.k8s.io/v1beta4
kind: ClusterConfiguration
networking:
  serviceSubnet: 10.96.0.0/12
  podSubnet: 192.168.0.0/16
  dnsDomain: cluster.local
controlPlaneEndpoint: <load-balancer-dns>:6443
apiServer:
  certSANs:
    - <load-balancer-dns>
clusterName: "hokaxbt"
---
apiVersion: kubeproxy.config.k8s.io/v1alpha1
kind: KubeProxyConfiguration
mode: iptables
---
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
serverTLSBootstrap: true
imageMinimumGCAge: 2m
imageMaximumGCAge: 24h
imageGCHighThresholdPercent: 60
imageGCLowThresholdPercent: 50
EOF
```

Update config with the `controller` IP address.

Then initialize the cluster:

```shell
kubeadm init --config ./kubeadm.yaml --upload-certs
```

SSH to worker nodes then execute the join command.

## Access Cluster

Download the config from `node-1` using the following command:

```shell
scp control-plane-1:/etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Then add new context in `.kube/config`, replace `kubernetes-admin` username with
`hokaxbt-admin`.

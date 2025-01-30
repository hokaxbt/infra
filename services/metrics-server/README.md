# Metrics Server

The Kubernetes Metrics Server is a tool that collects resource usage data for a
Kubernetes cluster. It's used to scale clusters automatically by providing
metrics to the Kubernetes API server.

## Installation

Add repo:

```shell
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
```

Install:

```shell
helm install metrics-server metrics-server/metrics-server \
  --namespace metrics-server \
  --create-namespace \
  --values values.yaml
```

Check the installation by running the following command:

```shell
kubectl top node
```

## Notes

Make sure cluster is initialized with KubeletConfiguration
`serverTLSBootstrap: true`.

For example:

```yaml
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
```

# Calico

Calico is a Container Network Interface (CNI) plugin that integrates with
Kubernetes.

It helps create and manage container networks within a Kubernetes cluster.
Calico provides features like IP address management (IPAM), network policy
enforcement, and flexible overlay or non-overlay networking options.

Compared to other CNI plugins, Calico offers robust network security,
scalability for large clusters, and efficient routing mechanisms.

## Installation

Intall tigera operator:

```shell
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/tigera-operator.yaml
```

Install Calico:

```shell
kubectl apply -f config.yaml
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

## Notes

-   `spec.calicoNetwork.ipPools.cidr` in Calico Installation definition should
    be the same as `networking.podSubnet` in `ClusterConfiguration` of Kubeadm

## References

-   [Calico Installation](https://docs.tigera.io/calico/latest/getting-started/kubernetes/self-managed-onprem/config-options)
-   [Enable WireGuard for a cluster](https://docs.tigera.io/calico/latest/network-policy/encrypt-cluster-pod-traffic#enable-wireguard-for-a-cluster)
-   [Configure MTU to maximize network performance](https://docs.tigera.io/calico/latest/networking/configuring/mtu)
-   [Encrypt in-cluster pod traffic](https://docs.tigera.io/calico/latest/network-policy/encrypt-cluster-pod-traffic#enable-wireguard-for-a-cluster)

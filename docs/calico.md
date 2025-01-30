# Calico

## Installation Config

```
# This section includes base Calico installation configuration.
# For more information, see: https://docs.tigera.io/calico/latest/reference/installation/api#operator.tigera.io/v1.Installation
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
```

## References

-   [Configure MTU to maximize network performance](https://docs.tigera.io/calico/latest/networking/configuring/mtu)
-   [Encrypt in-cluster pod traffic](https://docs.tigera.io/calico/latest/network-policy/encrypt-cluster-pod-traffic#enable-wireguard-for-a-cluster)

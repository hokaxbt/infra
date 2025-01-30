# OpenEBS

OpenEBS is a leading container-native storage solution designed specifically for
Kubernetes environments. It provides a seamless way to manage persistent storage
for containerized applications.

## Installation

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
    --values values.yaml
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

## Notes

-   Make sure all worker nodes have volume group called `ubuntu-vg`

## TODO

-   Setup dedicated label for SSD/HDD based worker nodes

## References

-   [OpenEBS Installation](https://openebs.io/docs/user-guides/local-storage-user-guide/local-pv-lvm/lvm-installation)

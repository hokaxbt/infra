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

or upgrade existing installation:

```shell
helm upgrade openebs openebs/openebs \
    --namespace openebs \
    --create-namespace \
    --values values.yaml
```

Create storage class:

```shell
kubectl create -f nvme.yaml
```

Create PVC for testing:

```shell
kubectl create -f nvme-test.yaml
```

If you run `kubectl get pvc` the status should be bound.

Delete pvc test:

```shell
kubectl delete -f nvme-test.yaml
```

## Notes

-   Make sure all worker nodes have LVM volume group called `ubuntu-vg`
-   Make sure at least one worker node have `disktype="nvme"` label
-   You can double check the installation by
    [deploying statefulsets](https://kubernetes.io/docs/tutorials/stateful-application/basic-stateful-set/)

## References

-   [Introduction to LVM](https://www.youtube.com/watch?v=dMHFArkANP8)
-   [OpenEBS LocalPV LVM Installation](https://openebs.io/docs/user-guides/local-storage-user-guide/local-pv-lvm/lvm-installation)
-   [OpenEBS LocalPV LVM Configuration](https://openebs.io/docs/user-guides/local-storage-user-guide/local-pv-lvm/lvm-configuration)

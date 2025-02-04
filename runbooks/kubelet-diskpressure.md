# Kubernetes: Kubelet DiskPressure

## What happen

Kubelet will mark node with label `node.kubernetes.io/disk-pressure` if
available disk space and inodes on either the node's root filesystem, image
filesystem, or container filesystem has satisfied an eviction threshold

## Check Disk Usage

Use tool such as [duf](https://github.com/muesli/duf) to check disk usage.

```shell
apt install duf
```

Then run `duf`:

```shell
duf -only local
```

example output:

```shell
╭─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ 6 local devices                                                                                                                                     │
├─────────────────────────────────────────┬────────┬────────┬────────┬───────────────────────────────┬──────┬─────────────────────────────────────────┤
│ MOUNTED ON                              │   SIZE │   USED │  AVAIL │              USE%             │ TYPE │ FILESYSTEM                              │
├─────────────────────────────────────────┼────────┼────────┼────────┼───────────────────────────────┼──────┼─────────────────────────────────────────┤
│ /                                       │   9.7G │   8.8G │ 454.4M │ [##################..]  90.2% │ ext4 │ /dev/ubuntu--vg/root                    │
│ /boot                                   │ 988.7M │ 185.1M │ 752.5M │ [###.................]  18.7% │ ext3 │ /dev/md0                                │
│ /var/lib/containers/storage/overlay     │   9.7G │   8.8G │ 454.4M │ [##################..]  90.2% │ ext4 │ /dev/ubuntu--vg/root                    │
│ /var/lib/kubelet/pods/156004a9-e419-421 │ 973.4M │ 368.0K │ 957.1M │ [....................]   0.0% │ ext4 │ /dev/ubuntu--vg-pvc--ee1197ed--f1d9--46 │
│ 0-8ab1-5322a919a7e5/volumes/kubernetes. │        │        │        │                               │      │ 8f--a083-/87d28394975f                  │
│ io~csi/pvc-ee1197ed-f1d9-468f-a083-87d2 │        │        │        │                               │      │                                         │
│ 8394975f/mount                          │        │        │        │                               │      │                                         │
│ /var/lib/kubelet/pods/8556f11c-cebe-4c3 │ 973.4M │ 292.0K │ 957.1M │ [....................]   0.0% │ ext4 │ /dev/ubuntu--vg-pvc--1eb55599--04f7--4d │
│ 5-870e-325feb8001fb/volumes/kubernetes. │        │        │        │                               │      │ c5--ada6-/8ac0bfe2e6bb                  │
│ io~csi/pvc-1eb55599-04f7-4dc5-ada6-8ac0 │        │        │        │                               │      │                                         │
│ bfe2e6bb/mount                          │        │        │        │                               │      │                                         │
│ /var/lib/kubelet/pods/b6296f1e-d0a3-472 │ 973.4M │ 280.0K │ 957.1M │ [....................]   0.0% │ ext4 │ /dev/ubuntu--vg-pvc--6b7cbcc0--7029--42 │
│ 6-bb15-e4e9e9dec921/volumes/kubernetes. │        │        │        │                               │      │ fb--954d-/0b014ca2ac3b                  │
│ io~csi/pvc-6b7cbcc0-7029-42fb-954d-0b01 │        │        │        │                               │      │                                         │
│ 4ca2ac3b/mount                          │        │        │        │                               │      │                                         │
╰─────────────────────────────────────────┴────────┴────────┴────────┴───────────────────────────────┴──────┴─────────────────────────────────────────╯
```

If there is high usage in `/var/lib/containers/storage/overlay` path this means
that CRI-O need to clean up.

Kubernetes has its own mechanism to remove unused image. Make sure to set the
following configuration in `KubeletConfiguration`.

```yaml
imageMinimumGCAge: 2m
imageMaximumGCAge: 24h
imageGCHighThresholdPercent: 60
imageGCLowThresholdPercent: 50
```

To update the `KubeletConfiguration` of existing cluster, run the following:

```shell
kubectl edit cm -n kube-system kubelet-config
```

Then apply the config for each node by running the following Ansible playbook:

```shell
ansible-playbook -i inventory.yaml playbooks/reconfigure_kubelet.yaml
```

Now double check that config are updated using the following command:

```shell
kubectl get --raw "/api/v1/nodes/<node-name>/proxy/configz" | jq
```

## Increase LV Size

To extend LV size for all worker nodes you can run the following command:

```shell
lvextend -r -L50G /dev/ubuntu-vg/root
```

## References

-   [Updating the KubeletConfiguration](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-reconfigure/)
-   [Garbage collection of unused containers and images](https://kubernetes.io/docs/concepts/architecture/garbage-collection/#containers-images)

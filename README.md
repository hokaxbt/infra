# HokaXBT's Infrastructure

This is source code of my infrastructure.

## Infrastructure Providers

- I use [Netcup](https://www.netcup.de) as my server provider. See
  [this guide](./docs/provision-netcup-server.md) on how to provision a Netcup
  server to be used for Kubernetes nodes.
- I use [Hetzner](https://www.hetzner.com) as my object storage provider.
- I use [Cloudflare](https://www.cloudflare.com) as my DNS provider.

## Kubernetes

- I use simple cluster configuration with single control plane node and multiple
  worker nodes.
- I use [Ansible](https://docs.ansible.com/) to bootstrap and configure my
  Kubernetes nodes. See [this guide](./docs/bootstrap-nodes.md) on how to
  bootstrap Kubernetes nodes.
- I use
  [Kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)
  to initialize and manage my Kubernetes cluster. See
  [this guide](./docs/initialize-cluster.md) on how to initialize a Kubernetes
  cluster.
- I backup etcd daily to my object storage. See
  [this guide](./docs/etcd-daily-backup.md) on how to setup etcd daily backup
- I use [Helm](https://helm.sh/) to manage my Kubernetes applications.
- I use [Flannel](https://github.com/flannel-io/flannel) as my CNI plugin. See
  [this guide](./services/flannel/README.md) on how to setup Flannel.
- I use
  [OpenEBS LocalPV LVM](https://openebs.io/docs/user-guides/local-storage-user-guide/local-pv-lvm/lvm-installation)
  as my CSI plugin. See [this guide](./services/openebs/README.md) on how to
  setup OpenEBS.

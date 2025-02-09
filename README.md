# HokaXBT's Infrastructure

This is source code of my infrastructure.

## Infrastructure Providers

- I use [Netcup](https://www.netcup.de) for my server provider. See
  [this guide](./docs/provision-netcup-server.md) on how to provision a Netcup
  server to be used for Kubernetes nodes.
- I use [Hetzner](https://www.hetzner.com) for my object storage provider.
- I use [Cloudflare](https://www.cloudflare.com) for my DNS provider.

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

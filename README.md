# HokaXBT's Infrastructure

This is source code of my infrastructure.

## Infrastructure Providers

- I use [Netcup](https://www.netcup.de) for my server provider.
- I use [Hetzner](https://www.hetzner.com) for my object storage provider.
- I use [Cloudflare](https://www.cloudflare.com) for my DNS provider.
- See [this guide](./docs/provision-netcup-server.md) on how to provision a
  Netcup server to be used for Kubernetes nodes.

## Kubernetes

- I use
  [Kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)
  to initialize and manage my Kubernetes cluster.
- See [this guide](./docs/initialize-cluster.md) on how to initialize a
  Kubernetes cluster.
- I use simple single node control plane and multiple worker nodes.
- I backup etcd daily to my object storage. See
  [this guide](./docs/etcd-daily-backup.md) on how to setup etcd daily backup

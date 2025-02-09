# HokaXBT's Infrastructure

This is the source code of my infrastructure.

## Infrastructure Providers

- I use [Netcup](https://www.netcup.de) as my server provider. See
  [this guide](./docs/provision-netcup-server.md) on how to provision a Netcup
  server to be used for Kubernetes nodes.
- I use [Hetzner](https://www.hetzner.com) as my object storage provider.
- I use [Cloudflare](https://www.cloudflare.com) as my DNS provider.

## Kubernetes

- I use a simple cluster configuration with single control plane node and
  multiple worker nodes.
- I use [Ansible](https://docs.ansible.com/) to bootstrap and configure my
  Kubernetes nodes. See [this guide](./docs/bootstrap-nodes.md) on how to
  bootstrap Kubernetes nodes.
- I use
  [Kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)
  to initialize and manage my Kubernetes cluster. See
  [this guide](./docs/initialize-cluster.md) on how to initialize a Kubernetes
  cluster.
- I backup etcd daily to my object storage. See
  [this guide](./docs/etcd-daily-backup.md) on how to setup etcd daily backup.
- I use [Helm](https://helm.sh/) to manage my Kubernetes applications.
- I use [Flannel](https://github.com/flannel-io/flannel) as my CNI plugin. See
  [this guide](./services/flannel/README.md) on how to setup Flannel.
- I use
  [OpenEBS LocalPV LVM](https://openebs.io/docs/user-guides/local-storage-user-guide/local-pv-lvm/lvm-installation)
  as my CSI plugin. See [this guide](./services/openebs/README.md) on how to
  setup OpenEBS.
- I use
  [Kubernetes Metrics Server](https://github.com/kubernetes-sigs/metrics-server)
  to provide metrics API for Kubernetes built-in autoscaling pipeline. See
  [this guide](./services/metrics-server/README.md) on how to setup Metrics
  Server.
- I use [Ingress NGINX](https://kubernetes.github.io/ingress-nginx/) as my
  ingress. See [this guide](./services/ingress-nginx/README.md) on how to setup
  Ingress NGINX.
- I use [Cert Manager](https://cert-manager.io/) to manage my TLS certificates.
  See [this guide](./services/cert-manager/README.md) on how to setup Cert
  Manager.
- I use [Grafana Loki](https://grafana.com/oss/loki/) to store my cluster's
  logs. See [this guide](./services/grafana-loki/README.md) on how to setup
  Grafana Loki.
- I use [Grafana Mimir](https://grafana.com/oss/mimir/) to store my cluster's
  metrics. See [this guide](./services/grafana-mimir/README.md) on how to setup
  Grafana Mimir.
- I use
  [Grafana Kubernetes Monitoring](https://github.com/grafana/k8s-monitoring-helm)
  to collect logs and metrics from my cluster. See
  [this guide](./services/grafana-monitoring/README.md) on how to setup Grafana
  Kubernetes Monitoring.
- I use [Grafana](https://grafana.com/) to visualize my cluster's logs and
  metrics. See [this guide](./services/grafana/README.md) on how to setup
  Grafana.

# Cert Manager

[Cert Manager](https://cert-manager.io/docs/) is an open-source tool designed to
manage TLS certificates within a Kubernetes cluster.

## Installation

Add Helm repo:

```shell
helm repo add jetstack https://charts.jetstack.io
helm repo update
```

Install `cert-manager`:

```shell
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --values ./values.yaml \
  --version v1.17.0
```

Create cluster issuer:

```shell
kubectl create -f config/cert-manager-cluster-issuer.yaml
```

Make sure the DNS of `tickerhot.com` is pointed to load balancer IP.

To validate the installation, create service test using the following command:

```shell
kubectl create -f config/cert-manager-test.yaml
```

Access `https://cert-manager-test.tickerhot.com`.

If you need to uninstall, run the following command:

```shell
helm -n cert-manager uninstall cert-manager
```

## Upgrade

Add Helm repo:

```shell
helm repo add jetstack https://charts.jetstack.io
helm repo update
```

Upgrade version:

```shell
helm upgrade cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --values ./values.yaml \
  --version v1.17.0
```

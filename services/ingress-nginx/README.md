# Ingress NGINX

[ingress-nginx](https://github.com/kubernetes/ingress-nginx) is an Ingress
controller for Kubernetes using NGINX as a reverse proxy and load balancer.

## Installation

Add `ingress-nginx` repo:

```shell
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```

Install `ingress-nginx`:

```shell
helm install ingress ingress-nginx/ingress-nginx \
    --namespace ingress-nginx \
    --create-namespace \
    --values values.yaml
```

Make sure `ingress-nginx` pods are scheduled across control plane nodes:

```shell
kubectl get pods -n ingress-nginx -o wide
```

Add load balancer service:

```shell
hcloud load-balancer add-service kubernetes --protocol tcp --listen-port 80 --destination-port 30080
hcloud load-balancer add-service kubernetes --protocol tcp --listen-port 443 --destination-port 30443
```

Make sure the service is healthy before continue next step:

```shell
hcloud load-balancer describe kubernetes
```

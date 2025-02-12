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
helm install default ingress-nginx/ingress-nginx \
    --namespace ingress-nginx \
    --create-namespace \
    --values values.yaml
```

Make sure `ingress-nginx` pods are running:

```shell
kubectl get pods -n ingress-nginx -o wide
```

This deployment will bind the following ports on the controller host:

- 80 (HTTP)
- 443 (HTTPS)
- 8181 (Default webserver)
-

## Notes

- Cluster with load balancer: `ingress-nginx` is deployed as DaemonSet that runs
  across control plane nodes and bind port `30080` to serve HTTP traffic and
  port `30443` to serve HTTPS traffic.
- Single control plane node: `ingress-nginx` is deployed as Deployment that bind
  to port 80 and 443.

## Cloudflare IPs

```shell
curl -s -L https://www.cloudflare.com/ips-v4 | tr "\n" "," > cloudflare-ipv4.txt
```

ipv6

```shell
curl -s -L https://www.cloudflare.com/ips-v6 | tr "\n" "," > cloudflare-ipv6.txt
```

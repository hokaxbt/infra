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

Make sure `ingress-nginx` pods are running:

```shell
kubectl get pods -n ingress-nginx -o wide
```

## Setup Cloudflare Tunnel

Install `cloudflared`:

```shell
brew install cloudflared
```

Login to cloudflare:

```shell
cloudflared tunnel login
```

Authorize the Cloudflare Tunnel.

Then create new tunnel:

```shell
cloudflared tunnel create kubernetes-ingress
```

Create new kubernetes credentials:

```shell
kubectl create secret generic cloudflare-tunnel-credentials -n ingress-nginx \
    --from-file=credentials.json=/Users/hokaxbt/.cloudflared/dd0b4dad-9399-40be-a9d0-5490ab55723a.json
```

Now route tunnel to dns:

```shell
cloudflared tunnel route dns kubernetes-ingress "*.hokaxbt.com"
```

## Example

Deploy example:

```shell
kubectl apply -f ingress-example.yaml
```

Service should be accessible via `https://ingress-example.hokaxbt.com`.

## Notes

- Cluster with load balancer: `ingress-nginx` is deployed as DaemonSet that runs
  across control plane nodes and bind port `30080` to serve HTTP traffic and
  port `30443` to serve HTTPS traffic.

# Flannel

Flannel is ...

## Installation

Create dedicated namespace:

```shell
kubectl create ns flannel-system
kubectl label --overwrite ns flannel-system pod-security.kubernetes.io/enforce=privileged
```

Add Helm repo and update:

```shell
helm repo add flannel https://flannel-io.github.io/flannel/
helm repo update
```

Install flannel:

```shell
helm install flannel --set podCidr="192.168.0.0/16" -n flannel-system flannel/flannel
```

## Verification

Test internal DNS query:

```shell
kubectl run -i -t busybox --rm --image=busybox:latest --restart=Never -- nslookup kubernetes.default.svc.cluster.local
```

Test external DNS query:

```shell
kubectl run -i -t busybox --rm --image=busybox:latest --restart=Never -- nslookup google.com
```

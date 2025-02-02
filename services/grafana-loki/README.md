# Grafana Loki

Grafana Loki is ...

## Installation

Create dedicated namespace for all monitoring services:

```shell
kubectl create ns monitoring
```

Create S3 secret credentials:

```shell
kubectl create secret generic hetzner-s3-credentials -n monitoring \
    --from-literal=S3_ENDPOINT='XXXX' \
    --from-literal=S3_REGION='XXXX' \
    --from-literal=S3_ACCESS_KEY='XXXX' \
    --from-literal=S3_SECRET_KEY='XXXX'
```

Make sure you have the following labels for all worker nodes:

```
topology.kubernetes.io/zone="<ZONE>"
```

This will allow to the Helm chart to deploy Grafana Loki across failure zones.

Run the following command to deploy Grafana Loki:

```shell
helm install grafana-loki ./chart -n monitoring --values values.yaml
```

Run the following command to upgrade Grafana Loki:

```shell
helm upgrade grafana-loki ./chart -n monitoring --values values.yaml
```

## Uninstall

Run the following command to uninstall the Grafana Mimir:

```shell
helm uninstall grafana-loki -n monitoring
```

## References

-   [Grafana Loki Configuration Parameters](https://grafana.com/docs/loki/latest/configure/)
-   [Grafana Loki Releases](https://github.com/grafana/loki/releases)

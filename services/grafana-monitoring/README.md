# k8s monitoring by Grafana

## Requirements

- [Grafana Loki](../grafana-loki/README.md) for logs
- [Grafana Mimir](../grafana-mimir/README.md) for metrics
- [Grafana Tempo](../grafana-tempo/README.md) for traces

## Installation

Add & update repo:

```shell
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

Run the following command to deploy Grafana Kubernetes Monitoring:

```shell
helm install grafana-monitoring grafana/k8s-monitoring --create-namespace -n monitoring --values values.yaml
```

Run the following command to upgrade Grafana Kubernetes Monitoring:

```shell
helm upgrade grafana-monitoring grafana/k8s-monitoring -n monitoring --values values.yaml
```

Run the following command to uninstall Grafana Kubernetes Monitoring:

```shell
helm uninstall grafana-monitoring -n monitoring
```

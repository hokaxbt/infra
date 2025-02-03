# k8s monitoring by Grafana

## Requirements

-   [Grafana Loki](../grafana-loki/) for logs
-   [Grafana Mimir](../grafana-mimir/) for metrics
-   [Grafana Tempo](../grafana-tempo/) for traces

## Installation

Add & update repo:

```shell
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

Run the following command to deploy Grafana Kubernetes Monitoring:

```shell
helm install grafana-kubernetes-monitoring grafana/k8s-monitoring -n monitoring --values values.yaml
```

Run the following command to upgrade Grafana Kubernetes Monitoring:

```shell
helm upgrade grafana-kubernetes-monitoring grafana/k8s-monitoring -n monitoring --values values.yaml
```

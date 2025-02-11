# Kubernetes Monitoring with Grafana

This setup uses Grafana to monitor a Kubernetes cluster.

## Prerequisites

The following services are required for this Grafana monitoring solution:

- [Grafana Loki](../grafana-loki/README.md) for log aggregation
- [Grafana Mimir](../grafana-mimir/README.md) for metrics storage
- [Grafana Tempo](../grafana-tempo/README.md) for distributed tracing

## Deployment

1. **Add and update the Grafana Helm repository:**

   ```bash
   helm repo add grafana https://grafana.github.io/helm-charts
   helm repo update
   ```

2. **Install Grafana Kubernetes Monitoring:**

   ```bash
   helm install grafana-monitoring grafana/k8s-monitoring --create-namespace -n monitoring --values values.yaml
   ```

3. **Upgrade Grafana Kubernetes Monitoring (if already installed):**

   ```bash
   helm upgrade grafana-monitoring grafana/k8s-monitoring -n monitoring --values values.yaml
   ```

4. **Uninstall Grafana Kubernetes Monitoring:**

   ```bash
   helm uninstall grafana-monitoring -n monitoring
   ```

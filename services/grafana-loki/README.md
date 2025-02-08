# Grafana Loki

Grafana Loki is ...

## Installation

Run the following command to deploy Grafana Loki:

```shell
helm install grafana-loki ./chart --create-namespace -n monitoring --values values.yaml
```

## Uninstall

Run the following command to uninstall the Grafana Mimir:

```shell
helm uninstall grafana-loki -n monitoring
```

## References

- [Grafana Loki Configuration Parameters](https://grafana.com/docs/loki/latest/configure/)
- [Grafana Loki Releases](https://github.com/grafana/loki/releases)

# Grafana Mimir

Grafana Mimir is ...

## Installation

Run the following command to deploy mimir:

```shell
helm install grafana-mimir ./chart --create-namespace -n monitoring --values values.yaml
```

## Check installation

Port forward the Grafana Mimir service:

```shell
kubectl port-forward svc/grafana-mimir 9200:80
```

Then access Grafana Mimir web admin via `http://localhost:9200`.

## Uninstall

Run the following command to uninstall the Grafana Mimir:

```shell
helm uninstall grafana-mimir -n monitoring
```

## References

- [Grafana Mimir Configuration Parameters](https://grafana.com/docs/mimir/latest/configure/configuration-parameters/)
- [Grafana Mimir Releases](https://github.com/grafana/mimir/releases)

# Grafana

Grafana is ...

## Installation

Add and update Helm repo:

```shell
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

Run the following command to install Grafana:

```shell
helm install grafana grafana/grafana -n monitoring -f values.yaml
```

Run the following command to update Grafana installation:

```shell
helm upgrade grafana grafana/grafana -n monitoring -f values.yaml
```

## Datasources

Run the following command to install datasources:

```shell
kubectl apply -f ./datasources
```

## Default values

Run the following command to get default values:

```shell
helm show values grafana/grafana > default-values.yaml
```

## References

- [Grafana Releases](https://github.com/grafana/grafana/releases)

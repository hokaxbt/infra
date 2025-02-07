# Grafana

Grafana is ...

## Installation

In order to run highly available Grafana Dashboard we need to run highly
available postgres first.

Run the following command to install Postgres HA:

```shell
kubectl apply -f resources.yaml
```

Wait for the cluster to be up and running:

```shell
kubectl wait --for=condition=Ready pod -l cnpg.io/cluster=grafana-db -n monitoring --timeout=300s
```

Add and update Helm repo:

```shell
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

Run the following command to install Grafana:

```shell
helm install grafana grafana/grafana -n monitoring -f values.yaml
```

## Default values

Run the following command to get default values:

```shell
helm show values grafana/grafana > default-values.yaml
```

## Grafana DB

Get the connection url using the following command:

```shell
kubectl get secret grafana-db-app -n monitoring -o jsonpath="{.data.uri}" | base64 -d
```

Access the postgresql using the following command:

```shell
kubectl cnpg psql grafana-db -n monitoring
```

## References

- [Grafana Releases](https://github.com/grafana/grafana/releases)
- [Set up Grafana for high availability](https://grafana.com/docs/grafana/latest/setup-grafana/set-up-for-high-availability/)

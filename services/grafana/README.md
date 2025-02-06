# Grafana

Grafana is ...

## Installation

In order to run highly available Grafana Dashboard we need to run highly
available postgres first.

Add and update Helm repo:

```shell
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

Create a Kubernetes Secret to store the database name, username, and password.
Run the following command to create a secret:

```shell
kubectl create secret generic grafana-db -n monitoring \
  --from-literal=username=postgres \
  --from-literal=password=password
```

Run the following command to install Postgres HA:

```shell
kubectl apply -f postgres.yaml -n monitoring
```

Wait for the cluster to be up and running:

```shell
kubectl wait --for=condition=Ready pod -l cnpg.io/cluster=grafana-db -n monitoring --timeout=300s
```

Get the connection url using the following command:

```shell
kubectl get secret grafana-db-app -o json | jq -r ".data.uri" | base64 --decode
```

Access the postgresql using the following command:

```shell
kubectl cnpg psql grafana-db -n monitoring
```

## Default values

Run the following command to get default values:

```shell
helm show values grafana/grafana > default-values.yaml
```

## References

- [Grafana Releases](https://github.com/grafana/grafana/releases)
- [Set up Grafana for high availability](https://grafana.com/docs/grafana/latest/setup-grafana/set-up-for-high-availability/)

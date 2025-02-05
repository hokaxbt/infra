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

## Default values

Run the following command to get default values:

```shell
helm show values grafana/grafana > default-values.yaml
```

## References

-   [Grafana Releases](https://github.com/grafana/grafana/releases)
-   [Set up Grafana for high availability](https://grafana.com/docs/grafana/latest/setup-grafana/set-up-for-high-availability/)

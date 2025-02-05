# CloudNative PG

CloudNative PG is ...

## Installation

Add and update Helm repo:

```shell
helm repo add cnpg https://cloudnative-pg.github.io/charts
helm repo update
```

Install CloudNative PG Operator:

```shell
helm install cnpg cnpg/cloudnative-pg --namespace cnpg-system --create-namespace
```

## References

-   [CloudNativePG Helm Charts](https://github.com/cloudnative-pg/charts)
-   [CloudNativePG Image Catalog](https://cloudnative-pg.io/documentation/1.25/image_catalog/)

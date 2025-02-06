# CloudNative PG

CloudNative PG is a Kubernetes-native operator for managing PostgreSQL clusters.
It simplifies the deployment, scaling, and management of PostgreSQL databases in
a Kubernetes environment.

With CloudNative PG, you can easily create and manage PostgreSQL clusters,
handle failovers, and ensure high availability and data consistency. It
integrates seamlessly with Kubernetes, providing a robust and scalable solution
for PostgreSQL in containerized environments.

## Installation

First, you need to add the CloudNative PG Helm repository and update it to
ensure you have the latest charts.

```shell
helm repo add cnpg https://cloudnative-pg.github.io/charts
helm repo update
```

Next, install the CloudNative PG Operator in a dedicated namespace. This will
set up the necessary components to manage your PostgreSQL clusters.

```shell
helm install cnpg cnpg/cloudnative-pg --namespace cnpg-system --create-namespace
```

Finally, apply the cluster image catalog to ensure that your clusters have
access to the necessary PostgreSQL images.

```shell
kubectl apply -f cluster-image-catalog.yaml
```

To verify that the installation was successful, you can check the status of the
pods in the `cnpg-system` namespace.

```shell
kubectl get pods -n cnpg-system
```

You should see pods related to the CloudNative PG Operator running. If
everything is set up correctly, you should be ready to create and manage your
PostgreSQL clusters using CloudNative PG.

## References

- [CloudNativePG Helm Charts](https://github.com/cloudnative-pg/charts)
- [CloudNativePG Image Catalog](https://cloudnative-pg.io/documentation/1.25/image_catalog/)

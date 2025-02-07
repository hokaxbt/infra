# RAID-0 or RAID-1

I initially set up RAID-0 for all my worker nodes, thinking I could simply
replace a worker node if a disk failed. However, I discovered that data loss
causes the system state to become corrupted. It's better to have temporary
unavailability during a reboot than to lose data completely.

Here is an example of how data loss affects a PostgreSQL Cluster HA setup:

```json
{
  "level": "info",
  "ts": "2025-02-07T07:40:16.339037958Z",
  "msg": "DB not available, will retry",
  "logger": "instance-manager",
  "logging_pod": "grafana-db-1",
  "controller": "instance-cluster",
  "controllerGroup": "postgresql.cnpg.io",
  "controllerKind": "Cluster",
  "Cluster": { "name": "grafana-db", "namespace": "monitoring" },
  "namespace": "monitoring",
  "name": "grafana-db",
  "reconcileID": "5ccb9727-9fdd-44bf-a308-5289a8424fcb",
  "logging_pod": "grafana-db-1",
  "err": "failed to connect to `user=streaming_replica database=postgres`: 10.104.73.213:5432 (grafana-db-rw): dial error: timeout: context deadline exceeded"
}
```

The PostgreSQL Cluster became corrupted and unusable.

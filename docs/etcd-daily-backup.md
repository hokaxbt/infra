# Daily Backup of ETCD to S3

Define new inventory file with the following content:

```yaml
all:
  hosts:
    controller:
      ansible_host: <controller-ip>
      ansible_python_interpreter: /usr/bin/python3.12
      bucket: kubernetes-etcd-backup
      s3_access_key: my-access-key
      s3_secret_key: my-secret-key
      s3_endpoint: my-endpoint
```

Run the following command to setup daily backup the etcd data:

```shell
ansible-playbook -i inventory-etcd-backup.yaml playbooks/etcd_daily_backup.yaml
```

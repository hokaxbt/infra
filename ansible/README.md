# Ansible Playbook

## Getting started

Create new `inventory.yaml` file with the following contents:

```yaml
controllers:
    hosts:
        <hostname>:
            ansible_host: <ip>
            topology:
                region: nbg1
                zone: nbg1-dc3

workers:
    hosts:
        <hostname>:
            ansible_host: <ip>
            topology:
                region: fsn1
                zone: fsn1-dc4
```

Then run the playbook using the following command:

```sh
ansible-playbook -i inventory.yaml playbooks/restart_kubelet.yaml
ansible-playbook -i inventory.yaml playbooks/reconfigure_kubelet.yaml
ansible-playbook -i inventory.yaml playbooks/update_nodes.yaml
```

## Playbooks

-   `bootstrap_nodes.yaml`: Install all required dependencies for Kubernetes
    nodes
-   `enable_kubelet_tls.yaml`:
    [Configure](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-certs/#kubelet-serving-certs)
    existing cluster to allow metrics-server

## References

-   [Overriding netplan configuration](https://askubuntu.com/a/1483563)

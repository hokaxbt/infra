# Ansible Playbook

## Getting started

```sh
ansible-playbook -i inventory.yaml -b --private-key=~/.ssh/id_ed25519 <playbook>
```

## Playbooks

-   `bootstrap_nodes.yaml`: Install all required dependencies for Kubernetes
    nodes
-   `enable_kubelet_tls.yaml`:
    [Configure](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-certs/#kubelet-serving-certs)
    existing cluster to allow metrics-server

## References

-   [Overriding netplan configuration](https://askubuntu.com/a/1483563)

# Ansible Playbook

### Inventory File

Create a new `inventory.yaml` file with the following contents:

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

### Running Playbooks

To run the playbooks, use the following commands:

```sh
ansible-playbook -i inventory.yaml playbooks/<name>.yaml
```

## Playbooks

| Playbook Name                 | Description                                                                                                                                 |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `bootstrap_nodes.yaml`        | Installs all required dependencies for Kubernetes nodes.                                                                                    |
| `enable_kubelet_tls.yaml`     | Configures the existing cluster to allow metrics-server by enabling signed kubelet serving certificates.                                    |
| `restart_kubelet.yaml`        | Restarts the kubelet service on all nodes.                                                                                                  |
| `reconfigure_kubelet.yaml`    | Reconfigures the kubelet service on all nodes.                                                                                              |
| `update_nodes.yaml`           | Updates the nodes by performing a distribution upgrade and rebooting if necessary.                                                          |
| `check_distribution.yaml`     | Checks the OS distribution and version to ensure they match the expected values.                                                            |
| `update_upgrade_dist.yaml`    | Updates the package cache and performs a distribution upgrade. It also checks if a reboot is required and performs the reboot if necessary. |
| `install_cloudflare_dns.yaml` | Configures Cloudflare DNS settings using systemd-networkd and systemd-resolved.                                                             |
| `secure_ssh.yaml`             | Secures SSH by adding authorized keys, disabling empty password login, disabling password login, and enabling PAM.                          |
| `install_kubernetes.yaml`     | Installs kubeadm, CRI-O, kubelet, and kubectl.                                                                                              |
| `install_wireguard.yaml`      | Installs Wireguard and checks if a reboot is required.                                                                                      |

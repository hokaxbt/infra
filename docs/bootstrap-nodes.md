# Bootstrap Nodes

To provision the nodes, you need Ansible installed. Please refer to
[Ansible's documentation](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
for installation instructions.

Add the following configuration to your `~/.ssh/config` file:

```shell
StrictHostKeyChecking=accept-new
```

This will remove the annoying prompt while not disabling key checking.

Add your SSH private key to `ssh-agent` to bypass the passkey prompt:

```shell
ssh-add ~/.ssh/id_ed25519
```

Create a new `inventory.yaml` file in the `ansible` directory as follows:

```yaml
controllers:
  hosts:
    controller:
      ansible_host: <controller-ip>

workers:
  hosts:
    worker-1:
      ansible_host: <worker-1-ip>
```

Once the [ansible](../ansible/README.md) environment is set up properly, you can
bootstrap nodes using the following command:

```sh
ansible-playbook -i inventory.yaml playbooks/bootstrap_nodes.yaml
```

## Next step

[Initialize the cluster](./initialize-cluster.md)

# Bootstrap Nodes

`ansible` must be installed to provision the nodes. Please refer to
[Ansible's documentation](https://github.com/hetznercloud/cli) to get started.

Add the following config to your `~/.ssh/config`:

```shell
StrictHostKeyChecking=accept-new
```

This will remove the annoying add new key prompt while not disable the checking.

Add your SSH private key to `ssh-agent` to bypass the passkey prompt:

```shell
ssh-add ~/.ssh/id_ed25519
```

Create new `inventory.yaml` in `ansible` directory as follows:

```sh
controllers:
  hosts:
    controller-1:
      ansible_host: <ip>
    controller-2:
      ansible_host: <ip>
    controller-3:
      ansible_host: <ip>

workers:
  hosts:
    worker-1:
      ansible_host: <ip>
    worker-2:
      ansible_host: <ip>
    worker-3:
      ansible_host: <ip>

```

Once `ansible` is set up properly, setup nodes as follows:

```sh
ansible-playbook -i inventory.yaml -b -v --private-key=~/.ssh/id_ed25519 bootstrap_nodes.yaml
```

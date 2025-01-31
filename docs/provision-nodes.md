# Provision Nodes

We use hybrid setup here where the control plane nodes are running on Hetzner
Cloud and the data nodes are running on Hetzner Bare Metal.

## Control Plane Nodes

`hcloud` must be installed to create the control plane nodes. Please refer to
[Hetzner Cloud CLI's documentation](https://github.com/hetznercloud/cli) to get
started.

Once `hcloud` is set up properly, create the control plane nodes as follows:

```shell
hcloud server create --name <name> --type cax11 --image ubuntu-24.04 --location fsn1 --ssh-key macbook,imac --placement-group kubernetes
```

## Worker Nodes

Assuming you have ordered server from Hetzner and
[Rescue System](https://docs.hetzner.com/robot/dedicated-server/troubleshooting/hetzner-rescue-system/)
is activated.

Now SSH to server:

```shell
ssh root@<server-ip>
```

Then run the image installer:

```shell
installimage -n <hostname> -r yes -l 0 -p /boot:ext3:1G,lvm:ubuntu-vg:all -v ubuntu-vg:root:/:ext4:10G
```

Then select Ubuntu 24.04, press `fn+f10` then wait for installer to finish.

Some info:

-   `-n` Set the hostname
-   `-r` Enable Software RAID
-   `-l` Sets the raid level
-   `-p` Sets the partition
-   `-v` Define root logical volume, 20GB is required to run kubernetes

After installation finished, reboot the server using `reboot` command.

Repeat the process for each worker node.

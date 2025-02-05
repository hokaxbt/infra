# Provision Nodes

Assuming you have ordered server from Hetzner and
[Rescue System](https://docs.hetzner.com/robot/dedicated-server/troubleshooting/hetzner-rescue-system/)
is activated.

Now SSH to server:

```shell
ssh root@<server-ip>
```

Then run the image installer:

```shell
# control plane node
installimage -n <hostname> -r yes -l 0 -p /boot:ext3:1G,lvm:ubuntu-vg:all -v ubuntu-vg:root:/:ext4:all

# worker node
installimage -n <hostname> -r yes -l 0 -p /boot:ext3:1G,lvm:ubuntu-vg:all -v ubuntu-vg:root:/:ext4:50G
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

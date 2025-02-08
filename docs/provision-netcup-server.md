# Provision Netcup Server

Step by step to provision
[Netcup Root Server](https://www.netcup.com/en/server/root-server).

## Install Ubuntu 24.04

1. Login to [Server Control Panel](https://www.servercontrolpanel.de/)
2. Select **Server**
3. Goto **Control** > Click **Shutdown**
4. Goto **Media** > Goto **DVD Drive** > Select **Ubuntu 24.04 Live Server** >
   Set boot mode > Click **Attach DVD**
5. Goto **Control** > Click **Start**
6. Goto **Screen** > Select **Install Ubuntu Server** > Configure the
   installation

   - For **Network Configuration**, Select automatic for ipv4 and wait until
     test mirror success. Do not forget to enable automatic ipv6 too.
   - For **Ubuntu Archive Mirror Configuration**, if failed to test mirror.
     Click `[help]` on top right of the screen, select **Enter shell**, edit
     `/etc/netplan/00-installer-config.yaml` and change `nameservers` to
     `1.1.1.1`. Then run `netplan apply` and `exit` to continue installation.

     ```yaml
     network:
       version: 2
       ethernets:
         ens3:
           dhcp4: true
           nameservers:
             addresses:
               - 1.1.1.1
     ```

   - For **Storage Configuration**, Select **Use entire disk**, Rename
     `ubuntu-lv` to `root` and resize it to 50GB for worker node, all available
     space for controller node.
   - For **SSH Configuration**, import SSH key from GitHub and disable login
     with password

7. Once installation finished, Goto **Media** > Click **Detach DVD**
8. Goto **Control** > Click **Powercycle**

## Setup root user

1. SSH to server with user that you created during installation

   ```shell
   ssh hoka@<server-ip>
   ```

2. Copy SSH authorized keys to root directory

   ```shell
   sudo cp ~/.ssh/authorized_keys /root/.ssh/authorized_keys
   ```

3. Logout and ssh to server with root user

## Update SSH Configuration (Optional)

1. Run the following command to edit your config:

   ```shell
   code ~/.ssh/config
   ```

2. Add the following configuration:

   ```
   Host controller
      HostName <ip-address>
      User hoka
   ```

## Next step

[Bootstrap Nodes](./bootstrap-nodes.md)

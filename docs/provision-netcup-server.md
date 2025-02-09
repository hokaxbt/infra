# Provision Netcup Server

Step-by-step guide to provision a
[Netcup Root Server](https://www.netcup.com/en/server/root-server).

## Install Ubuntu 24.04

1. Log in to the [Server Control Panel](https://www.servercontrolpanel.de/)
2. Select **Server**
3. Go to **Control** -> Click **Shutdown**
4. Go to **Media** -> **DVD Drive** -> Select **Ubuntu 24.04 Live Server** ->
   Set boot mode -> Click **Attach DVD**
5. Go to **Control** -> Click **Start**
6. Go to **Screen** -> Select **Install Ubuntu Server** -> Configure the
   installation

   - For **Network Configuration**, select automatic for IPv4 and wait for
     mirror test to succeed. Enable automatic IPv6 as well.
   - For **Ubuntu Archive Mirror Configuration**, if mirror test fails: Click
     `[help]` in the top right, select **Enter shell**, edit
     `/etc/netplan/00-installer-config.yaml` and change nameservers to
     `1.1.1.1`. Run netplan apply and exit to continue installation.

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

   - For **Storage Configuration**, select Use entire disk, rename `ubuntu-lv`
     to `root`. For worker nodes, resize to 50GB; for controller nodes, use all
     available space.
   - For **SSH Configuration**, import SSH key from GitHub and disable password
     login

7. After installation completes, go to **Media** -> Click **Detach DVD**
8. Go to **Control** -> Click **Powercycle**

## Setup root user

1. SSH into the server with your installation user.

   ```shell
   ssh hoka@<server-ip>
   ```

2. Copy SSH authorized keys to root directory.

   ```shell
   sudo cp ~/.ssh/authorized_keys /root/.ssh/authorized_keys
   ```

3. Log out and SSH back to server as root user.

## Update SSH Configuration (Optional)

1. Edit your SSH config:

   ```shell
   code ~/.ssh/config
   ```

2. Add the configuration:

   ```
   Host controller
      HostName <ip-address>
      User root
   ```

## Next step

[Bootstrap Nodes](./bootstrap-nodes.md)

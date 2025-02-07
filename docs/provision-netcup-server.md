# Provision Netcup Server

Step by step to provision
[Netcup Root Server](https://www.netcup.com/en/server/root-server).

## Install Ubuntu 24.04

1. Login to [Server Control Panel](https://www.servercontrolpanel.de/)
2. Select **Server**
3. Goto **Media** > Goto **DVD Drive** > Select **Ubuntu 24.04 Live Server** >
   Set boot mode > Click **Attach DVD**
4. Goto **Control** > Click **Shutdown** (Wait 2 minutes) > Click **Start**
5. Goto **Screen** > Select **Install Ubuntu Server** > Configure the
   installation
6. For **Network Configuration**, Select automatic for ipv4 and wait until test
   mirror success.
7. For **Storage Configuration**, Select **Use entire disk**, Resize `ubuntu-lv`
   to 50GB for worker node, all available disk for controller node
8. Confirm the installation and click **Reboot now**
9. Goto **Media** > Click **Detach DVD**
10. Goto **Control** > Click **Shutdown** (Wait 2 minutes) > Click **Start**

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

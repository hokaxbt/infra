**Goal**: Expose multiple control planes as one domain using Cloudflare Tunnel

1. SSH to `controller-1`
2. Add `cloudflared` repo:

   ```shell
   sudo mkdir -p --mode=0755 /usr/share/keyrings
   curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
   echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main" | sudo tee /etc/apt/sources.list.d/cloudflared.list
   sudo apt-get update && sudo apt-get install cloudflared
   ```

3. Authenticate `cloudflared`:

   ```shell
   cloudflared tunnel login
   ```

4. Create a tunnel:

   ```shell
   cloudflared tunnel create kubernetes-cluster-endpoint
   ```

5. Create configuration:

```shell
cat <<EOF | tee /root/.cloudflared/config.yaml
url: https://localhost:6443
tunnel: 9726eddc-f3ea-41d0-ac3b-xxxx
credentials-file: /root/.cloudflared/9726eddc-f3ea-41d0-ac3b-xxx.json
EOF
```

6. Set route:

   ```shell
    cloudflared tunnel route dns kubernetes-cluster-endpoint cluster.hokaxbt.com
   ```

7. Run `cloudflared`:

   ```shell
   cloudflared service install
   systemctl start cloudflared
   systemctl status cloudflared
   ```

8. Verify tunnel:

   ```shell
   cloudflared tunnel info kubernetes-cluster-endpoint
   ```

9. Update kubeconfig

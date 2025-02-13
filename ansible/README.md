# Ansible Playbook

Step-by-step

## Create inventory

Create a file named `inventory.yml` in the root of the project.

```yaml
all:
  vars:
    distro_name: Ubuntu
    distro_version: "24.04"

    wireguard_port: <port>

    # Load balancer of Control Plane
    load_balancer_dns: <mycluster.example.com>
    load_balancer_port: 6443
    primary_control_plane: control-plane-1
  children:
    load_balancers:
    control_planes:
    workers:

load_balancers:
  hosts:
    load-balancer-1:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12
      wireguard_ip: 10.0.0.0

control_planes:
  hosts:
    control-plane-1:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12
      wireguard_ip: 10.0.10.1
    control-plane-2:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12
      wireguard_ip: 10.0.10.2
    control-plane-3:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12
      wireguard_ip: 10.0.10.3

workers:
  hosts:
    worker-1:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12
      wireguard_ip: 10.0.20.1
```

## Initialize the cluster

Set `mycluster.example.com` to the IP of the load balancer.

Run the following command to initialize the cluster:

```shell
ansible-playbook -i inventory.yaml playbooks/initialize_cluster.yaml
```

## Access the cluster

Run the following command to access the cluster locally:

```shell
scp control-plane-1:/etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

## Approve Certificates

Run the following command to view pending certificates:

```shell
kubectl get csr
```

Run the following command to approve a certificate:

```shell
kubectl certificate approve <certificate-name>
# or approve all certificates
kubectl certificate approve $(kubectl get csr -o jsonpath='{.items[*].metadata.name}')
```

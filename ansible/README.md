# Ansible Playbook

Step-by-step

## Create inventory

```yaml
all:
  vars:
    distro_name: Ubuntu
    distro_version: "24.04"

    wireguard_mask_bits: 8
    wireguard_port: 51871
  children:
    load_balancers:
    control_planes:
    workers:

load_balancers:
  hosts:
    load-balancer-1:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12
      wireguard_ip: 10.0.0.1

control_planes:
  hosts:
    control-plane-1:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12
      wireguard_ip: 10.0.0.2
    control-plane-2:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12
      wireguard_ip: 10.0.0.3
    control-plane-3:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12
      wireguard_ip: 10.0.0.4

workers:
  hosts:
    worker-1:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12
      wireguard_ip: 10.0.0.5
```

## Initialize the cluster

Run the following command to initialize the cluster:

```shell
ansible-playbook -i inventory.yaml playbooks/initialize_cluster.yaml
```

Add Control Plane Load Balancer IP to DNS e.g. `sub.domain.tld`.

## Update Control Plane Load Balancer Configuration

Run the following command to update the control plane load balancer
configuration:

```shell
ansible-playbook -i inventory-netcup.yaml playbooks/system_install_haproxy.yaml
```

## Setup Nodes

Run the following command to setup the nodes:

```shell
ansible-playbook -i inventory-netcup.yaml playbooks/nodes_setup.yaml -l control_planes,workers
```

# Ansible Playbook

Step-by-step

## Create inventory

```yaml
control_plane_lbs:
  hosts:
    control-plane-lb:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12

control_planes:
  hosts:
    control-plane-1:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12
    control-plane-2:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12
    control-plane-3:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12

workers:
  hosts:
    worker-1:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12
    worker-2:
      ansible_host: <ip>
      ansible_python_interpreter: /usr/bin/python3.12
```

## Setup Control Plane Load Balancer

Run the following command to setup the control plane load balancer:

```shell
ansible-playbook -i inventory-netcup.yaml playbooks/control_plane_setup_lb.yaml -l control-plane-lb
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

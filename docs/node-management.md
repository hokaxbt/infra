# Node Management

## Add Control Plane Node

1. [Provision](./provision-nodes.md) new control plane node.
2. [Define](../ansible/README.md) new control plane node in your
   `ansible/inventory.yaml` file.
3. Bootstrap node by running the following command in [ansible](../ansible/)
   directory.

    ```shell
    ansible-playbook -i inventory.yaml -l <new-control-plane-hostname> playbooks/bootstrap_nodes.yaml
    ```

4. Get the join command by running the following command in one of the control
   plane node.

    ```shell
    kubeadm init phase upload-certs --upload-certs
    kubeadm token create --print-join-command
    ```

5. SSH to new control plane node and execute the join command.

    ```shell
    kubeadm join <ip>:6443 --token <token> --discovery-token-ca-cert-hash <hash> --control-plane --certificate-key <cert>
    ```

6. Check the cluster status, make sure the new control plane node is ready.

    ```shell
    kubectl get nodes
    ```

7. Check wethere any pending certificate issuance.

    ```shell
    kubectl get csr
    ```

8. Approve pending certificate for the new control plane node (if any)

    ```shell
    kubectl certificate approve <csr-name>
    ```

9. Add the control plane node to load balancer.

    ```shell
    hcloud load-balancer add-target kubernetes --server controller-4
    ```

## Remove Control Plane Node

1. First drain the control plane node.

    ```shell
    kubectl drain <node-name> --delete-emptydir-data --ignore-daemonsets
    ```

2. Delete node.

    ```shell
    kubectl delete node <node-name>
    ```

3. Remove control plane node from `ansible/inventory.yaml`
4. Remove etcd member from the cluster.

    ```shell
    ETCDCTL_API=3 etcdctl \
        --endpoints 127.0.0.1:2379 \
        --cert=/etc/kubernetes/pki/etcd/server.crt \
        --key=/etc/kubernetes/pki/etcd/server.key \
        --cacert=/etc/kubernetes/pki/etcd/ca.crt \
        member list -w table

    ETCDCTL_API=3 etcdctl \
        --endpoints 127.0.0.1:2379 \
        --cert=/etc/kubernetes/pki/etcd/server.crt \
        --key=/etc/kubernetes/pki/etcd/server.key \
        --cacert=/etc/kubernetes/pki/etcd/ca.crt \
        member remove <member-id>
    ```

5. Remove control plane node from load balancer.

    ```shell
    hcloud load-balancer remove-target kubernetes --server controller-1
    ```

6. Delete server

    ```shell
    hcloud server delete <name>
    ```

## Replace Control Plane Node

Step by step:

1. Add Control Plane Node
2. Remove Control Plane Node

## Add Worker Node

1. [Provision](./provision-nodes.md) new worker node.
2. [Define](../ansible/README.md) new worker node in your
   `ansible/inventory.yaml` file.
3. Bootstrap node by running the following command in [ansible](../ansible/)
   directory.

    ```shell
    ansible-playbook -i inventory.yaml -l <hostname> -b --private-key=~/.ssh/id_ed25519 playbooks/bootstrap_nodes.yaml
    ```

4. Get the join command by running the following command in one of the control
   plane node.

    ```shell
    kubeadm token create --print-join-command
    ```

5. SSH to new worker node and execute the join command.

    ```shell
    kubeadm join <ip>:6443 --token <token> --discovery-token-ca-cert-hash <hash>
    ```

6. Check the cluster status, make sure the new worker node is ready.

    ```shell
    kubectl get nodes
    ```

7. Check wether any pending certificate issuance.

    ```shell
    kubectl get csr
    ```

8. Approve pending certificate for the new node (if any)

    ```shell
    kubectl certificate approve <csr-name>
    ```

9. Add worker labels:

    ```shell
    kubectl label node <name> node-role.kubernetes.io/worker=""
    kubectl label node <name> topology.kubernetes.io/region="fsn1"
    kubectl label node <name> topology.kubernetes.io/zone="fsn1-dc14"
    kubectl label node <name> disktype="nvme"
    ```

## Remove Worker Node

1. First drain the worker node.

    ```shell
    kubectl drain <node-name> --delete-emptydir-data --ignore-daemonsets
    ```

2. Delete node.

    ```shell
    kubectl delete node <node-name>
    ```

3. Remove worker node from `ansible/inventory.yaml`
4. Delete server

## References

-   [Operating etcd clusters for Kubernetes](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/)

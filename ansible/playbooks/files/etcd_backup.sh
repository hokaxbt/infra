#!/bin/sh

# Create a directory for etcd backup if it does not exist
mkdir -p /root/etcd-backup

# Define the name of backup file
FILE_NAME=etcd-$(date +"%F%T").db

# Define the full path of backup file
ETCD_PATH=/root/etcd-backup/$FILE_NAME

ETCDCTL_API=3 etcdctl \
    --endpoints=https://127.0.0.1:2379 \
    --cacert=/etc/kubernetes/pki/etcd/ca.crt \
    --cert=/etc/kubernetes/pki/etcd/server.crt \
    --key=/etc/kubernetes/pki/etcd/server.key \
    snapshot save $ETCD_PATH

# Deleting etcd backup files older than 7 days
[ -d /root/etcd-backup ] && find /root/etcd-backup -cmin +10080 -delete

# Compressing etcd backup files
tar czfp /root/etcd-backup.tar.gz --absolute-names /root/etcd-backup/

# Uploading etcd backup files to s3
mc cp /root/etcd-backup.tar.gz s3/kubernetes-etcd-backup/

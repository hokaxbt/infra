#!/bin/sh

# Create a directory for etcd backup if it does not exist
BACKUP_PATH=/root/$(hostname)-etcd-backup

if [ ! -d "$BACKUP_PATH" ]; then
  mkdir -p "$BACKUP_PATH"
fi

# Define the name of backup file
FILE_NAME=$(hostname)-etcd-$(date +"%F%T").db

# Define the full path of backup file
ETCD_PATH=$BACKUP_PATH/$FILE_NAME

ETCDCTL_API=3 etcdctl \
    --endpoints=https://127.0.0.1:2379 \
    --cacert=/etc/kubernetes/pki/etcd/ca.crt \
    --cert=/etc/kubernetes/pki/etcd/server.crt \
    --key=/etc/kubernetes/pki/etcd/server.key \
    snapshot save $ETCD_PATH

# Deleting etcd backup files older than 7 days
[ -d $BACKUP_PATH ] && find $BACKUP_PATH -cmin +10080 -delete

# Compressing etcd backup files
tar czfp $BACKUP_PATH.tar.gz --absolute-names $BACKUP_PATH/

# Uploading etcd backup files to s3
mc cp $BACKUP_PATH.tar.gz s3/kubernetes-etcd-backup/

#!/bin/sh

[ -d /root/etcd-restore ] && rm -r /root/etcd-restore
mkdir -p /root/etcd-restore-s3

mc cp s3/kubernetes-etcd-backup/etcd-backup.tar.gz /root/etcd-restore-s3
[ -f /root/etcd-restore-s3/etcd-backup.tar.gz ] && tar -xf /root/etcd-restore-s3/etcd-backup.tar.gz -C /

RECENT_BACKUP=/root/etcd-backup/$(ls -Art /root/etcd-backup/ | tail -n 1)
echo $RECENT_BACKUP

ETCDCTL_API=3 etcdctl snapshot restore --data-dir /root/etcd-restore $RECENT_BACKUP
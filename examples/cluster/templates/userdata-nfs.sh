#!/bin/bash

###
### Set time
###
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
sed -ie '/ZONE=/ s/=.*/="America\/Los_Angeles"/' /etc/sysconfig/clock

###
### Mount EFS volumes
###
# Can switch to using AWS' EFS helper
#   yum -y install amazon-efs-utils
#   mount -t efs
#   fstab: efs defaults,_netdev 0 0
#   mount -a -t efs
# Look at https://docs.aws.amazon.com/efs/latest/ug/troubleshooting-efs-mounting.html#automount-fails
#   if have issues with multiple EFS mounts at boot time

# mounts is a list of "host:service"
if ! rpm -qa | grep -qw nfs-utils; then
    yum -y install nfs-utils
fi

# Create mount points
mountBase=/mnt/efs
mkdir -p $${mountBase}
cd $${mountBase}
for d in ${mounts}; do
  dir=$(echo $d | cut -d: -f2)
  mkdir -p $${dir}
  chmod 0000 $${dir}
done
### Setup fstab
# Backup fstab
cp -p /etc/fstab /etc/fstab.$(date +%F)
for m in ${mounts}; do
  host=$(echo $m | cut -d: -f1)
  mount=$(echo $m | cut -d: -f2)
  echo -e "$${host}:/ $${mountBase}/$${mount} nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 0 0" >> /etc/fstab
  if [ "$${mount}" == "nexus" ]; then
    # Create user/group
    groupadd -g 200 nexus
    adduser -lM -u 200 -g nexus -d /mnt/efs/nexus nexus
  fi
done
# If EFS was just created, it may not be ready yet. Can take up to 90 seconds
# how to test? Or loop till mounted with 90 second timeout?
# touch file under mountpoint, loop till file gone
# findmnt -rno
mount -at nfs4

echo "INFO: Ensuring all nfs4 volumes are mounted"
for mountPoint in $(findmnt --fstab -rnt nfs4 -o TARGET); do
  while ! findmnt --kernel -rnt nfs4 -o TARGET,SOURCE $${mountPoint}; do
    sleep 1
    mount -at nfs4
  done
  if [ "$${mountPoint}" == "$${mountBase}/nexus" ]; then
    chown nexus:nexus $${mountPoint}
  fi
done

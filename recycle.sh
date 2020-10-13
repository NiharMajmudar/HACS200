#!/bin/bash

ct_num=$1

# Kill currently running tail process
kill -9 $(ps aux | grep "tail -n 0 -F /var/lib/lxc/$ct_num/rootfs/var/log/auth.log" | awk '{print $2}')

sleep 10

# Unmount the container
pct unmount $ct_num

# Stop the container
pct unlock $ct_num
pct stop $ct_num --skiplock 1

# Unmount container again
# (it’s silly, but we need to do this because of pct’s inconsistency)
pct unmount $ct_num

# Destroy the container
pct destroy $ct_num


# Prepare template for cloneing
pct unlock 201

# We want to repeatedly try the clone process until it succeeds
while ! pct clone 201 $ct_num --experimental false; do
    # Wait for 30 seconds before trying again
    sleep 30;
done

pct unlock 201

# Update networking configuration for container 201
if [ $ct_num -eq "102" ]; then
    pct set 102 --net0 name=eth0,bridge=vmbr0,ip=172.20.0.3/16,gw=172.20.0.1
fi

# Restart desired container
pct start $ct_num

# Mount the container
pct unlock $ct_num
rm -f /run/lock/lxc/pve-config-$ct_num.lock
pct mount $ct_num

echo "Recycled container $ct_num"

# Restart monitor script
tail -n 0 -F /var/lib/lxc/$ct_num/rootfs/var/log/auth.log | ./monitor.sh $ct_num &
exit

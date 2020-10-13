#!/bin/bash

ct_num=$1
ip_addr=$2

# Wait time (in seconds)
WAIT_TIME=300

if [ $ct_num -eq "101" ]; then
    ct_ip="172.20.0.2"
else
    ct_ip="172.20.0.3"
fi

# Wait for specified amount of time
echo "Started waiting for timeout on container $ct_num"
sleep $WAIT_TIME

# Check to see if malware.sh was created; if it was, block the user
ct_files=$(ls -1 /var/lib/lxc/$ct_num/rootfs/root/)
if echo $ct_files | grep "malware.txt"; then
    # Permanently block attacker
    iptables --table filter --insert FORWARD 1 --out-interface vmbr0 --source $ip_addr --destination $ct_ip --jump DROP
    echo "Blocked attacker for ip $ip_addr"
fi


# Delete previously created rules
iptables --table filter --delete FORWARD --protocol tcp --out-interface vmbr0 --source $ip_addr --destination $ct_ip --destination-port 22 --jump ACCEPT
iptables --table filter --delete FORWARD --protocol tcp --out-interface vmbr0 --source 0.0.0.0/0 --destination $ct_ip --destination-port 22 --jump DROP

echo "Beginning recycle of $ct_num"
./recycle.sh $ct_num &
exit

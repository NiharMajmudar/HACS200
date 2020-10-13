#!/bin/bash

ct_num=$1

if [ $ct_num -eq "101" ]; then
    ct_ip="172.20.0.2"
else
    ct_ip="172.20.0.3"
fi

while read a
do
    # Monitor for login event
    accepted_line=$(echo "$a" | grep "sshd" | grep "Accepted password for")
    if [ ! -z "$accepted_line" ]; then
	# Extract IP address
	ip_addr=$(echo "$a" | awk -F" " '{ print $11 }')

	echo "New connection from $ip_addr"

	# Allow only the attacker in the container
	iptables --table filter --insert FORWARD 1 --protocol tcp --out-interface vmbr0 --source $ip_addr --destination $ct_ip --destination-port 22 --jump ACCEPT
	iptables --table filter --insert FORWARD 2 --protocol tcp --out-interface vmbr0 --source 0.0.0.0/0 --destination $ct_ip --destination-port 22 --jump DROP

	./wait.sh $ct_num $ip_addr &
	exit
    fi
done

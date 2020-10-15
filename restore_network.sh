#!/bin/bash

# this script is used to restore the networking configuration
# in the event of a cypherpath shutdown

ip addr add XXX.X.XXX.XX/26 dev enp4s1
ip addr add XXX.X.XXX.XXX/26 dev enp4s1
ip addr add XXX.X.XXX.XXX/26 dev enp4s1

ip route add default via XXX.X.XXX.XX table hnetwork1

ip rule add from XXX.XX.X.X table hnetwork1
ip rule add from XXX.XX.X.X table hnetwork1
ip rule add from XXX.XX.X.X table hnetwork1

iptables-restore < Networking_Info/10_9_20

Honeypot_Project/firewall/firewall_rules.sh

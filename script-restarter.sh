#!/bin/bash


# set PATH (for crontab)
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# kill all processes, check for MITM, monitor.sh, wait.sh, recycle.sh, and tail
# kill tail
tail1=$(ps aux | grep "tail -n" | grep 101 | awk '{print $2}')
if [ ! -z "$tail1" ]
then
	kill $tail1
fi
sleep 1
tail2=$(ps aux | grep "tail -n" | grep 102 | awk '{print $2}')
if [ ! -z "$tail2" ]
then
        kill $tail2
fi
sleep 1
tail3=$(ps aux | grep "tail -n" | grep 103 | awk '{print $2}')
if [ ! -z "$tail3" ]
then
        kill $tail3
fi
sleep 1
tail4=$(ps aux | grep "tail -n" | grep 104 | awk '{print $2}')
if [ ! -z "$tail4" ]
then
        kill $tail4
fi
sleep 1
# kill MITM
pid_mitm1=$(ps aux | grep node | grep 101 | awk -F' ' '{print $2}')
if [ ! -z "$pid_mitm1" ]
then
	kill $pid_mitm1
fi
sleep 1
pid_mitm2=$(ps aux | grep node | grep 102 | awk -F' ' '{print $2}')
if [ ! -z "$pid_mitm2" ]
then
        kill $pid_mitm2
fi
sleep 1
pid_mitm3=$(ps aux | grep node | grep 103 | awk -F' ' '{print $2}')
if [ ! -z "$pid_mitm3" ]
then
        kill $pid_mitm3
fi
sleep 1
pid_mitm4=$(ps aux | grep node | grep 104 | awk -F' ' '{print $2}')
if [ ! -z "$pid_mitm4" ]
then
        kill $pid_mitm4
fi
sleep 1
# kill wait.sh
wait1=$(ps aux | grep wait.sh | grep 101 | awk -F' ' '{print $2}')
if [ ! -z "$wait1" ]
then
        kill $wait1
fi
sleep 1
wait2=$(ps aux | grep wait.sh | grep 102 | awk -F' ' '{print $2}')
if [ ! -z "$wait2" ]
then
        kill $wait2
fi
sleep 1
wait3=$(ps aux | grep wait.sh | grep 103 | awk -F' ' '{print $2}')
if [ ! -z "$wait3" ]
then
        kill $wait3
fi
sleep 1
wait4=$(ps aux | grep wait.sh | grep 104 | awk -F' ' '{print $2}')
if [ ! -z "$wait4" ]
then
        kill $wait4
fi
sleep 1
# kill monitor.sh
monitor1=$(ps aux | grep monitor.sh | grep 101 | awk -F' ' '{print $2}')
if [ ! -z "$monitor1" ]
then
        kill $monitor1
fi
sleep 1
monitor2=$(ps aux | grep monitor.sh | grep 102 | awk -F' ' '{print $2}')
if [ ! -z "$monitor2" ]
then
        kill $monitor2
fi
sleep 1
monitor3=$(ps aux | grep monitor.sh | grep 103 | awk -F' ' '{print $2}')
if [ ! -z "$monitor3" ]
then
        kill $monitor3
fi
sleep 1
monitor4=$(ps aux | grep monitor.sh | grep 104 | awk -F' ' '{print $2}')
if [ ! -z "$monitor4" ]
then
        kill $monitor4
fi
sleep 1
# kill recycle.sh
recycle1=$(ps aux | grep recycle.sh | grep 101 | awk -F' ' '{print $2}')
if [ ! -z "$recycle1" ]
then
        kill $recycle1
fi
sleep 1
recycle2=$(ps aux | grep recycle.sh | grep 102 | awk -F' ' '{print $2}')
if [ ! -z "$recycle2" ]
then
        kill $recycle2
fi
sleep 1
recycle3=$(ps aux | grep recycle.sh | grep 103 | awk -F' ' '{print $2}')
if [ ! -z "$recycle3" ]
then
        kill $recycle3
fi
sleep 1
recycle4=$(ps aux | grep recycle.sh | grep 104 | awk -F' ' '{print $2}')
if [ ! -z "$recycle4" ]
then
        kill $recycle4
fi
sleep 1
# get rid of potential ip table rule
iptables --table filter --delete INPUT --source 0.0.0.0/0 --destination 172.20.0.1 --jump DROP
sleep 1
# restart recycling for each
nohup ./recycle.sh 101 >>/root/errlog10101 2>&1 &
sleep 1
nohup ./recycle.sh 102 >>/root/errlog10102 2>&1 &
sleep 1
nohup ./recycle.sh 103 >>/root/errlog10103 2>&1 &
sleep 1
nohup ./recycle.sh 104 >>/root/errlog10104 2>&1 &

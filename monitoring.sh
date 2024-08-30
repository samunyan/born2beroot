#!bin/bash

ARCH=$(uname -srvmo)
pCPUs=$(grep 'physical id' /proc/cpuinfo | uniq | wc -l)
vCPUs=$(grep processor /proc/cpuinfo | uniq | wc -l)
RAM_available=$(free -h | grep Mem | awk '{print $2}')
RAM_used=$(free -h | grep Mem | awk '{print $3}')
RAM_rate=$(free -h | grep Mem | awk '{printf("%.2f%%", $3 / $2 * 100)}')
DISK_available=$(df -h --total | grep total | awk '{print $2}')
DISK_used=$(df -h --total | grep total | awk '{print $3}')
DISK_rate=$(df -h --total | grep total | awk '{print $5}')
CPU_load=$(uptime | awk '{printf("%.f%%", $6 * 100)}')
Last_reboot=$(who -b | awk '{print($3 " " $4)}')
LVM=$(if [ $(lsblk | grep lvm | wc -l) != 0 ]; then echo active; else echo \
"not active"; fi)
TCP=$(grep TCP / proc/net/sockstat | awk '{print $3}')
nUsers=$(who | wc -l)
IPV4=$(hostname -I |awk '{print $1}')
MAC=$(ip addr | grep link/ether | awk '{print $2}')
nSudoCmds=$(grep COMMAND /var/log/sudo/sudo.log | wc -l)

wall "\
#Architecture   : $ARCH
#Physical CPUs  : $pCPUs
#Virtual CPUs   : $vCPUs
#RAM usage      : $RAM_used / $RAM_available ($RAM_rate)
#Disk usage     : $DISK_used / $DISK_available ($DISK_rate)
#CPU load       : $CPU_load
#Last reboot    : $Last_reboot
#LVM            : $LVM
#TCP            : $TCP
#Active users   : $nUsers
#Network        : $IPv4 ($MAC)
#Sudo           : $nSudoCmds executed sudo commands"


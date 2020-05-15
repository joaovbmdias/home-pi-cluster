#!/bin/bash

new_password=$1
user=$2
new_hostname=$3
cur_hostname="$(hostname)"
new_ip=$4
new_dns=$5

if [ -z "$new_hostname" ]; then
    new_hostname="$(hostname)"
fi

if [ -z "$new_ip" ]; then
   new_ip=$(hostname -I)
fi

if [ -z "$new_dns" ]; then
    new_dns=$(cat /etc/resolv.conf | grep -Eo 'nameserver (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
fi

echo
echo System Update
sudo apt-get update -y && sudo apt-get upgrade -y
echo SUCCESS!

echo
echo Changing User Password
echo "$user"':'"$new_password" | sudo chpasswd
echo SUCCESS!

echo
echo Changing Hostname
sed -i "s/${cur_hostname}/${new_hostname}/g" /etc/hosts
sed -i "s/${cur_hostname}/${new_hostname}/g" /etc/hostname
echo SUCCESS!

echo
echo Configure Static IP
echo "static ip_address=${new_ip}/24" >> /etc/dhcpcd.conf
echo "static routers=192.168.1.1" >> /etc/dhcpcd.conf
echo "static domain_name_servers=${new_dns}" >> /etc/dhcpcd.conf
echo SUCCESS!

echo
echo Enable Container Features
sed -i ' 1 s/.*/& cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory/' /boot/cmdline.txt
echo SUCCESS!

echo
echo Switch Debian Firewall to Legacy Configurations
update-alternatives --set iptables /usr/sbin/iptables-legacy
update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
echo SUCCESS!
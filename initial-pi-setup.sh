
#!/bin/bash

new_password=raspberry
user=pi

new_hostname=raspberrypi2
cur_hostname="$(hostname)"

echo
echo System Update
sudo apt-get update -y && sudo apt-get upgrade -y
echo Successfully Updated
echo

echo
echo Change User Password
echo "$user"':'"$new_password" | sudo chpasswd
echo

echo
echo Changing Hostname from "$cur_hostname" to "$new_hostname"
hostnamectl set-hostname $new_hostname
echo Successfully Changed Hostname
echo

echo
echo Configure Static IP
echo "static ip_address=192.168.1.40/24" >> /etc/dhcpcd.conf
echo "static routers=192.168.1.1" >> /etc/dhcpcd.conf
echo "static domain_name_servers=192.168.1.204" >> /etc/dhcpcd.conf
echo

echo
echo Enable Container Features
sed -i ' 1 s/.*/& cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory/' /boot/cmdline.txt
echo Enabled
echo

echo
echo Switch Debian Firewall to Legacy Configurations
update-alternatives --set iptables /usr/sbin/iptables-legacy
update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
echo Done
echo
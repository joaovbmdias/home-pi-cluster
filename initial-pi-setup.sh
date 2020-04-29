ECHO update system
sudo apt-get update -y && sudo apt-get upgrade -y
ECHO successfully updated 

ECHO change user password
passwd

ECHO change hostname
sudo vi /etc/hostname

ECHO configure static IP
sudo vi /etc/dhcpcd.conf

ECHO enable container features
sudo vi /boot/cmdline.txt #cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory

ECHO switch Debian firewall to legacy config
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
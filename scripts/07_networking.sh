#!/bin/bash -eux

networkFile=/etc/network/interfaces
resolvConfFile=/etc/resolv.conf

echo "configure network for DHCP"
# configure network
interfaces="# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback
# The primary network interface
allow-hotplug eth0
iface eth0 inet dhcp
"

# configure dns resolv.conf
resolvConf="nameserver 8.8.8.8
nameserver 8.8.4.4"

# write network interface file
echo "$interfaces" | sudo tee $networkFile

# write resolv.conf file
echo "$resolvConf" | sudo tee $resolvConfFile

# restart network
#service networking restart

rm -f /etc/udev/rules.d/70-persistent-net.rules;
touch /etc/udev/rules.d/70-persistent-net.rules;
rm -f /lib/udev/rules.d/75-persistent-net-generator.rules;
rm -rf /dev/.udev/ /var/lib/dhcp/*;

echo "pre-up sleep 2" >> $networkFile

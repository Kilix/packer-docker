#!/bin/bash -eux

# enable memory and swap cgroup
cat <<EOF > /etc/default/grub
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.
GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet net.ifnames=0 biosdevname=0"
GRUB_CMDLINE_LINUX="debian-installer=fr_FR cgroup_enable=memory swapaccount=1"
EOF

/usr/sbin/update-grub

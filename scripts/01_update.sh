#!/bin/bash -eux

# ensure the correct kernel headers are installed
$APT_BIN -y -q install linux-generic linux-headers-generic

DEBIAN_FRONTEND=noninteractive $APT_BIN -y -q dist-upgrade
#DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical $APT_BIN -q -y -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" upgrade

# $APT_BIN -y -q --force-yes install linux-generic linux-headers-$(uname -r)
$APT_BIN install -q -y linux-image-extra-$(uname -r)

# update package index on boot
cat <<EOF > /etc/init/refresh-apt.conf
description "update package index"
start on networking
task
exec /usr/bin/apt-get update
EOF

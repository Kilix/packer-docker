#!/bin/bash
#
usage() {
   echo "usage : $0 new_hostname"
   exit 1
}

[ -z $1 ] && usage

oldhost=`hostname`
newhost=$1

for file in \
   /etc/exim4/update-exim4.conf.conf \
   /etc/printcap \
   /etc/hostname \
   /etc/hosts \
   /etc/ssh/ssh_host_rsa_key.pub \
   /etc/ssh/ssh_host_dsa_key.pub \
   /etc/motd \
   /etc/postfix/main.cf \
   /etc/ssmtp/ssmtp.conf
do
   [ -f $file ] && sed -i.old -e "s:$oldhost:$newhost:g" $file
done

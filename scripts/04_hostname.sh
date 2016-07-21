#!/bin/bash -eux

oldhostname=`hostname`
olddomain=`hostname -d`
oldfqdn=`hostname -f`
newhostname=$NETWORK_HOSTNAME
newdomain=$NETWORK_DOMAIN
newfqdn=$newhostname.$newdomain

echo "old hostname $oldhostname"
echo "old domain $olddomain"
echo "old fqdn $oldfqdn"
echo "new hostname $newhostname"
echo "new domain $newdomain"
echo "new fqdn $newfqdn"

echo $newhostname > /etc/hostname

for file in \
/etc/exim4/update-exim4.conf.conf \
/etc/printcap \
/etc/motd \
/etc/postfix/main.cf \
/etc/ssmtp/ssmtp.conf
do
    if [ -f $file ]; then
    sed -i.old -e "s:$oldfqdn:$newfqdn:g" $file
    fi
done

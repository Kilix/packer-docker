#!/bin/bash -eux

SMB_WORKGROUP=workgroup

# install samba
echo "install samba ..."
debconf-set-selections <<< 'samba samba/run_mode  select daemons'
debconf-set-selections <<< 'samba-common samba-common/encrypt_passwords  boolean true'
debconf-set-selections <<< 'samba-common samba-common/dhcp  boolean false'
debconf-set-selections <<< "samba-common samba-common/workgroup  string $SMB_WORKGROUP"
debconf-set-selections <<< 'samba-common samba-common/do_debconf  boolean true'
apt-get -y install samba samba-common
apt-get -y install cifs-utils

echo $'# start custom share #\n\n\n# end custom share #' | tee -a /etc/samba/smb.conf

# add vagrant user to samba
smbuser=vagrant
smbpass=$smbuser

# add or change vagrant samba user password
echo -ne "$smbpass\n$smbpass\n" | sudo smbpasswd -a -s $smbuser

# add /home/vagrant/share shared directory
mkdir -p /home/vagrant/share
chown -R vagrant:vagrant /home/vagrant/share

sed -i '1h;1!H;${;g;s/\(# start custom share #\).*\(# end custom share #\)/\1\
[vagrant]\
path = \/home\/vagrant\/share\
browseable = yes\
readonly = no\
writeable = yes\
guest ok = yes\
locking = no\
valid users = vagrant\
create mask = 0644\
directory mask = 0755\
force user = vagrant\
force group = vagrant\
comment = vagrant data share\
\2/;}' /etc/samba/smb.conf

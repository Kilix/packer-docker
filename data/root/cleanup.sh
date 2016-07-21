#!/bin/bash

dataDir=/home/vagrant/data
log=/home/vagrant/*.log

# Remove APT cache
sudo apt-get clean -y
sudo apt-get autoclean -y
 
# Remove APT files
find /var/lib/apt -type f | sudo  xargs rm -f

# Remove bash history
unset HISTFILE
sudo rm -f /root/.bash_history
sudo rm -f /home/vagrant/.bash_history

# Remove install log
sudo rm $log

# remove vagrant/data 
sudo rm -rf $dataDir

# Zero free space to aid VM compression
dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY

#!/bin/bash -eux

echo "configure base /etc/hosts"
# reconfigure /etc/hosts : add vagrant.local and vagrant.localhost loopback domain
sed -i '/127.0.0.1\s\+localhost/ a \
127.0.0.1\tvagrant.local vagrant.localhost' /etc/hosts
echo '' | tee -a /etc/hosts
echo $'# start custom hosts #\n\n\n# end custom hosts #' | tee -a /etc/hosts
echo '' | tee -a /etc/hosts

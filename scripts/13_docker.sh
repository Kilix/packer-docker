#!/bin/bash -eux

$APT_BIN install -y apt-transport-https python python-pip lsb-release

repoversion=`lsb_release -si | sed 's/.*/\L&/'`'-'`lsb_release -sc`

# install docker
# wget -q -O - https://get.docker.io/gpg | apt-key add -
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo $repoversion main" > /etc/apt/sources.list.d/docker.list
$APT_BIN update -qq
$APT_BIN install -q -y --force-yes cgroup-lite apparmor
$APT_BIN purge lxc-docker
apt-cache policy docker-engine
$APT_BIN install -q -y --force-yes docker-engine
usermod -a -G docker vagrant
service docker restart


# install docker compose
pip install docker-compose

# install docker machine
curl -L https://github.com/docker/machine/releases/download/v$DOCKER_MACHINE_VERSION/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine && \
chmod +x /usr/local/bin/docker-machine

docker version
docker-compose --version
docker-machine version

# docker machine bash completion
curl -s -L https://raw.githubusercontent.com/docker/machine/v$DOCKER_MACHINE_VERSION/contrib/completion/bash/docker-machine.bash > /etc/bash_completion.d/docker-machine
curl -s -L https://raw.githubusercontent.com/docker/machine/v$DOCKER_MACHINE_VERSION/contrib/completion/bash/docker-machine-prompt.bash > /etc/bash_completion.d/docker-machine-prompt
curl -s -L https://raw.githubusercontent.com/docker/machine/v$DOCKER_MACHINE_VERSION/contrib/completion/bash/docker-machine-wrapper.bash > /etc/bash_completion.d/docker-machine-wrapper

# docker compose bash completion
curl -s -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose


# docker compose zsh completion
mkdir -p /home/vagrant/.zsh/completion
curl -s -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/zsh/_docker-compose > /home/vagrant/.zsh/completion/_docker-compose

echo 'fpath=(~/.zsh/completion $fpath)' >> /home/vagrant/.zshrc
echo 'autoload -Uz compinit && compinit -i' >> /home/vagrant/.zshrc
chown -R vagrant:vagrant /home/vagrant/.zsh
# exec $SHELL -l

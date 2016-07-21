Docker host Linux Packer template
=================================

Packer template to build a Linux Virtual Machine for Vagrant + Virtualbox to host Docker containers.

VM based on Ubuntu 16.04 LTS  with the following packages :

* Git
* Vim
* Docker engine 1.11.2
  * Docker-compose 1.7.1
  * Docker-machine 0.7.0
* Samba server : to host CIFS network shared folder inside the VM. (The most performant share folder system for windows vagrant host)

The vagrant box is available on https://atlas.hashicorp.com/kilix/boxes/docker-host/

Prerequisites
-------------

* [Packer](https://www.packer.io/)

Build
-----

to build the VM and update the box on atlas

```bash
# copy config file
cp config.json.dist config.json
# edit it if needed
vim config.json

# build the box
ATLAS_TOKEN=<your-atlas-token> make
```

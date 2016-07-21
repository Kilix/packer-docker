#!/bin/bash -eux

# install curl to fix broken wget while retrieving content from secured sites
$APT_BIN -y -q install curl

# install some useful tools and editor
$APT_BIN -y -q install debconf-utils acl bash-completion
$APT_BIN -y -q install rsync wget ntpdate
$APT_BIN -y -q install dos2unix tofrodos ack-grep vim screen tmux
$APT_BIN -y -q install unzip zip p7zip unrar lzma

# install git
$APT_BIN -y -q install git

# install nfs
$APT_BIN -y -q install nfs-common portmap

# remove old vim-tiny
$APT_BIN -y -q remove vim-tiny

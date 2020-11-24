#!/bin/bash

# description:
#   setup script for physical servers

# libvirt
sudo yum install -y \
  qemu-kvm virt-manager \
  libvirt \
  libvirt-python \
  virt-install \
  virt-viewer \
  nfs-utils
  
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
# git, etc
sudo yum install -y \
  git \
  wget \
  mysql-devel \
  sshpass
# redis
sudo yum install -y epel-release && sudo yum install redis
# sudo systemctl enable redis.service # agentのみ
# sudo systemctl start redis.service # agentのみ
# rsync
yum -y install rsync xinetd

# ruby
sudo yum install -y centos-release-scl
sudo yum install -y rh-ruby27

COMMAND="scl enable rh-ruby27 bash"
PROFILE_PATH="/home/hmori/.bash_profile"
result=$(grep "$COMMAND" "$PROFILE_PATH")
if [[ -z $result ]]; then
  echo $COMMAND >> $PROFILE_PATH
fi

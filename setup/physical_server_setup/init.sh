#!/bin/bash

# description:
#   setup script for physical servers

# libvirt
sudo yum install -y qemu-kvm virt-manager libvirt libvirt-python virt-install virt-viewer
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
# git
sudo yum install -y git wget
# ruby
sudo yum install -y centos-release-scl
sudo yum install -y rh-ruby27
scl enable rh-ruby27 bash && ruby -v

COMMAND="scl enable rh-ruby27 bash"
PROFILE_PATH="/home/hmori/.bash_profile"
result=$(grep "$COMMAND" "$PROFILE_PATH")
if [[ -z $result ]]; then
  echo $COMMAND >> $PROFILE_PATH
fi

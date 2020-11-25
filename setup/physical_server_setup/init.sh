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
sudo yum install -y epel-release && sudo yum install -y redis
# sudo systemctl enable redis.service # agentのみ
# sudo systemctl start redis.service # agentのみ
# rsync
yum -y install rsync xinetd

# etc
sudo yum install -y centos-release-scl
sudo yum install -y gcc make
sudo yum install -y libxml2 libxslt libxml2-devel libxslt-devel

# ruby
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
~/.rbenv/bin/rbenv init
source ~/.bash_profile
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
sudo ~/.rbenv/plugins/ruby-build/install.sh
sudo yum install -y openssl-devel readline-devel zlib-devel
rbenv install 2.7.2
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
rbenv global 2.7.2

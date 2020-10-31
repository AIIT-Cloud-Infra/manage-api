#!/bin/bash

sudo cat <<EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/mainline/centos/7/$basearch/
gpgcheck=0
enabled=1
EOF

sudo yum install -y nginx
nginx -v
sudo systemctl enable nginx
sudo systemctl start nginx

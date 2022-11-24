#!/bin/bash
yum install epel-release
yum update
yum install nginx
cat <<EOT >> /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=https://nginx.org/packages/mainline/<OS>/<OSRELEASE>/$basearch/
gpgcheck=0
enabled=1
EOT
systemctl start nginx
systemctl enable nginx
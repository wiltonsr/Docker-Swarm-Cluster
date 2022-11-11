#! /bin/bash

# Fix repos
cd /etc/yum.repos.d/
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# disable swap
swapoff -a
# keeps the swaf off during reboot
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Disable SELINUX
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# Install vim
yum install -y vim net-tools telnet

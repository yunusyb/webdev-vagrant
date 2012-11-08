#!/bin/bash

# disable selinux
echo 0 >/selinux/enforce

echo "Enabling EPEL:"
su -c 'rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-7.noarch.rpm'
#yum -y update

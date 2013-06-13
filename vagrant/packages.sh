#!/bin/sh

# Puppet will take care of adding the puppet, EPEL, and IUS repositories and
# all these packages, but we can save a lot of time on the first provisioning
# by running these commands first.

echo "Installing EPEL and IUS..."
if ! rpm -q epel-release > /dev/null ; then
  rpm -U --nosignature http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
fi

if ! rpm -q ius-release > /dev/null ; then
  rpm -U --nosignature http://dl.iuscommunity.org/pub/ius/stable/Redhat/6/x86_64/ius-release-1.0-11.ius.el6.noarch.rpm
fi

echo "Installing mandatory packages..."
packages="php php-mysql php-gd php-pdo php-xml php-mbstring php-pecl-apc php-pecl-memcache php-devel pcre-devel httpd-devel memcached php-pear-DB iptables git pwgen screen bison byass cscope ctags diffstat doxygen flex gcc gcc-c++ gcc-gfortran gettext indent intltool patch patchutils subversion swig systemtap tig redhat-rpm-config rpm-build system-config-firewall openssl-devel pam-devel augeas"

if ! rpm -q $packages > /dev/null; then
  yum install -q -y $packages
fi

#!/bin/sh

# Puppet will take care of adding the puppet, EPEL, and IUS repositories and
# all these packages, but we can save a lot of time on the first provisioning
# by running these commands first.

if ! rpm -q epel-release; then
  rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
fi

packages="php php-mysql php-gd php-pdo php-xml php-mbstring php-pecl-apc php-pecl-memcache php-devel pcre-devel httpd-devel memcached php-pear-DB iptables git pwgen screen bison byass cscope ctags diffstat doxygen flex gcc gcc-c++ gcc-gfortran gettext indent intltool patch patchutils subversion swig systemtap tig redhat-rpm-config rpm-build system-config-firewall openssl-devel pam-devel augeas"

if ! rpm -q $packages > /dev/null; then
  yum install -q -y $packages
fi

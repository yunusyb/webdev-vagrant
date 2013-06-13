#!/bin/sh

# Puppet requires these packages, but by running one yum command here we can save
# a lot of time on the first provisioning.
packages="php php-mysql php-gd php-pdo php-xml php-mbstring php-pecl-apc php-pecl-memcache php-devel pcre-devel httpd-devel php-pecl-memcached memcached php-pear-DB"
packages="$packages iptables git pwgen screen bison byass cscope ctags diffstat doxygen flex gcc gcc-c++ gcc-gfortran gettext indent intltool patch patchutils subversion swig systemtap tig zsh redhat-rpm-config rpm-build system-config-firewall openssl-devel pam-devel augeas"

if ! rpm -q $packages > /dev/null; then
  yum install -q -y $packages
  pear channel-update pecl.php.net
fi

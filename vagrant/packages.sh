#!/bin/sh

# Puppet requires these packages, but by running one yum command here we can save
# a lot of time on the first provisioning.
packages="php php-mysql php-gd php-pdo php-xml php-mbstring php-pecl-apc php-pecl-memcache php-devel pcre-devel httpd-devel php-pecl-memcached memcached php-pear-DB"

if ! rpm -q $packages > /dev/null; then
  yum install -q -y $packages
fi

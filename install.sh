#!/bin/bash

# disable selinux
echo 0 >/selinux/enforce

echo "Enabling EPEL:"
su -c 'rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-7.noarch.rpm'
#yum -y update

echo "Enabling Varnish-cache.org repo:"
rpm --nosignature -i http://repo.varnish-cache.org/redhat/varnish-3.0/el5/noarch/varnish-release-3.0-1.noarch.rpm

# Installing the virtualbox guest additions
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
cd /tmp
wget http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm VBoxGuestAdditions_$VBOX_VERSION.iso

# run puppet
/usr/bin/puppet apply --modulepath /vagrant/modules /vagrant/manifests/default.pp

# pdo_mysql hack
yum -y install php-devel php-pear mysql-devel httpd-devel
pecl install pdo_mysql
echo extension=pdo_mysql.so > /etc/php.d/pdo_mysql.ini 
service httpd restart

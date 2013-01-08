#!/bin/bash

# disable selinux
echo 0 >/selinux/enforce

# Enabling EPEL, IUS, Puppet Labs, and Varnish repos:
cat > /etc/yum.repos.d/puppetlabs.repo << EOM
[puppetlabs]
name=puppetlabs
baseurl=http://yum.puppetlabs.com/el/6/products/\$basearch
enabled=1
gpgcheck=0
EOM

cat > /etc/yum.repos.d/varnish.repo << EOM
[varnish-3.0]
name=Varnish 3.0 for Enterprise Linux 6 - $basearch
baseurl=http://repo.varnish-cache.org/redhat/varnish-3.0/el6/$basearch
enabled=1
gpgcheck=0
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-VARNISH
EOM

if [ ! -f /etc/yum.repos.d/epel.repo ]
then
    rpm -U http://dl.iuscommunity.org/pub/ius/stable/Redhat/6/x86_64/epel-release-6-5.noarch.rpm
fi

if [ ! -f /etc/yum.repos.d/ius.repo ]
then
	rpm -U http://dl.iuscommunity.org/pub/ius/stable/Redhat/6/x86_64/ius-release-1.0-10.ius.el6.noarch.rpm
fi

# Make sure we're up to date
yum update -y

# Ensure VBox extensions are the current version
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
if [ ! -f /etc/vbox_version ]
then 
    touch /etc/vbox_version 
fi

if diff /home/vagrant/.vbox_version /etc/vbox_version > /dev/null
then
    echo "Installing the virtualbox guest additions:"
    cd /vagrant/files
    ISO="VBoxGuestAdditions_$VBOX_VERSION.iso"
    echo $ISO
    if [ ! -f $ISO ]
    then
        wget http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso
    fi
    mount -o loop VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
    sh /mnt/VBoxLinuxAdditions.run
    umount /mnt
    echo $VBOX_VERSION > /etc/vbox_version
fi

# run puppet
/usr/bin/puppet apply --modulepath /vagrant/modules /vagrant/manifests/default.pp

# pdo_mysql hack
if [ -d /etc/httpd -a ! -f /etc/php.d/pdo_mysql.ini ] 
then
    echo "Installing PDO_MYSQL:"
    yum -y install php-devel php-pear mysql-devel httpd-devel
    pecl channel-update pecl.php.net
    pecl install pdo_mysql
    echo extension=pdo_mysql.so > /etc/php.d/pdo_mysql.ini
    service httpd restart
fi

# external server mount
mount --bind /vagrant/files/server /server

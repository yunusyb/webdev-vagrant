#!/bin/bash

# database
mysql <<EOF
CREATE DATABASE IF NOT EXISTS vagrant_default;
EOF

### START Drupal-specific config
# Comment out this section if you are not running Drupal
#
## if Drupal is not installed, install it
if [ ! -d /server/core/drupal-* ]; then
  mkdir /server/core
  mkdir /server/data
  cd /server/core
  drush -y dl drupal
  cd drupal-*
  mv sites /server/data
  ln -s ../../data/sites ./
  cd /server
  ln -s core/drupal-* ./htdocs
fi
## add copies of vagrant-specific settings.php
if [ ! -f /server/htdocs/sites/default/settings.php ]; then
  cp /server/vagrant/settings.php /server/htdocs/sites/default/
  if [ ! -d /server/htdocs/sites/default/files ]; then
    mkdir /server/htdocs/sites/default/files
  fi
  if [ -d /server/htdocs/sites/default/files ]; then
    # Yes, I know 777 perms are bad, but this VM is not exposed to the world
    # and permissions/ownership gets messy if we don't do it this way
    chmod -R 777 /server/htdocs/sites/default/files
  fi
  cd /server/htdocs/sites/all/modules
  drush dl -y memcache
  cd /server/htdocs/sites default
  drush si -y minimal --account-name=admin --account-pass=admin
  service httpd restart > /dev/null
fi
#
#### END Drupal-specific config

# make sure vagrant ssh puts us in the webroot directory
if ! grep -iq "^cd /server/htdocs" ~vagrant/.bashrc; then
  cat >> ~vagrant/.bashrc <<EOF
# get into webroot at login
cd /server/htdocs
EOF
fi

if [ ! -f ~vagrant/.ssh/config ] ; then
	touch ~vagrant/.ssh/config
fi

#if ! iptables-save | grep -- '--dport 80' > /dev/null; then
#  iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
#fi

service iptables stop > /dev/null

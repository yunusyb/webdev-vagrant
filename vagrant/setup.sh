#!/bin/bash

# MySQL doesn't like "-" in database names, so replace with underscores
projectname=${1//[ -]/_}
# database
mysql <<EOF
CREATE DATABASE IF NOT EXISTS vagrant_$projectname;
EOF

# add copies of vagrant-specific settings.php
if [ ! -f /server/htdocs/sites/$projectname/settings.php ]; then
  if [ ! -d /server/htdocs/sites/$projectname ]; then
    mkdir "/server/htdocs/sites/$projectname/"
  fi
  cp /vagrant/vagrant/settings.php "/server/htdocs/sites/$projectname/"
  if [ ! -d /server/htdocs/sites/$projectname/files]; then
    chmod -R 777 "/server/htdocs/sites/$projectname/files"
  fi
  # make $projectname and $1 both available as sitenames to Drupal
  ln -s /server/htdocs/sites/$projectname /server/htdocs/sites/$1
  service httpd restart
fi

# make sure vagrant ssh puts us in the drupal directory
if ! grep -iq "^cd /server/htdocs" ~vagrant/.bashrc; then
  cat >> ~vagrant/.bashrc <<EOF
# get into drupal at login
cd /server/htdocs
EOF
fi

if [ ! -f ~vagrant/.ssh/config ] ; then
	touch ~vagrant/.ssh/config
fi

if ! iptables-save | grep -- '--dport 80' > /dev/null; then
  iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
fi

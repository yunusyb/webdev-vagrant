#!/bin/bash

# HOWTO add another multisite:
# 1) Add "CREATE DATABASE ..."
# 2) Add sitename to "for site in ..."

# database
mysql <<EOF
CREATE DATABASE IF NOT EXISTS vagrant_projectname;
EOF

# add copies of vagrant-specific settings.php
for site in wtg btw; do
  if [ ! -f /server/htdocs/sites/$site/settings.php ]; then
    cp /vagrant/vagrant/settings.php "/server/htdocs/sites/$site/"
    chmod -R 777 "/server/htdocs/sites/$site/files"
    service httpd restart
  fi
done

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

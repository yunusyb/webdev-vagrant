#!/bin/bash

# MySQL doesn't like "-" in database names, so replace with underscores
projectname=${1//[ -]/_}
# database
mysql <<EOF
CREATE DATABASE IF NOT EXISTS vagrant_$projectname;
EOF

if [ ! -f ~vagrant/.ssh/config ] ; then
	touch ~vagrant/.ssh/config
fi

#if ! iptables-save | grep -- '--dport 80' > /dev/null; then
#  iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
#fi

service httpd restart > /dev/null
puppet resource service iptables ensure=stopped > /dev/null

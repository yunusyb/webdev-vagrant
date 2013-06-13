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

# TODO: Debug possible segfaulting httpd; uncomment for a quick fix.
# service httpd restart

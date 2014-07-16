#!/bin/sh
#
# For some reason the newrelic-daemon stays running but stops reporting after a while.
# This cron job restarts the daemon nightly

if [ -f /etc/init.d/newrelic-daemon ]; then
  /sbin/service newrelic-daemon restart;
fi

if [ -f /etc/init.d/newrelic-sysmond ]; then
  /sbin/service newrelic-sysmond restart;
fi

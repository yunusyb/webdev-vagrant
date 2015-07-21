#!/bin/bash

# post-puppet.sh: Add your shell commands here.

# Populate Drupal database if it doesn't already have a site in there
DRUPALDB=`echo 'show tables;' | sudo mysql default | wc -l`
if [ ${DRUPALDB} -lt 1 ]
  then 
    cd /server/htdocs && drush si -y;
fi

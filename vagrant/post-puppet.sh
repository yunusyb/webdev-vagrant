#!/bin/bash

# post-puppet.sh: Add your shell commands here.

# Populate Drupal database if it doesn't already have a site in there
# DRUPALDB=`echo 'show tables;' | sudo mysql default | wc -l`
# if [ ${DRUPALDB} -lt 1 ]
#   then
#     cd /server/htdocs && drush si -y;
# fi

#Composer
if [ ! -f /usr/local/bin/composer ];
then
  curl -sS https://getcomposer.org/installer | php
  mv composer.phar /usr/local/bin/composer
  sudo chmod +x /usr/local/bin/composer
fi

#Codeception
if [ ! -f /usr/local/bin/codecept ];
then
  wget --quiet http://codeception.com/releases/1.8.7/codecept.phar
  mv codecept.phar /usr/local/bin/codecept
  sudo chmod +x /usr/local/bin/codecept
fi

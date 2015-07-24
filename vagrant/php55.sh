#!/bin/bash

# Upgrade to PHP 5.5, yeah, it's ugly, but it's Vagrant

sudo yum replace -y php --replace-with=php55u && sudo yum install -y php55u-opcache && sudo service httpd restart

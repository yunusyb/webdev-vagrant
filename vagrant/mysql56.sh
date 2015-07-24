#!/bin/bash

# Upgrade to MySQL 5.6, yeah, it's ugly, but it's Vagrant

sudo yum replace -y mysql-server --replace-with=mysql56u-server && sudo service mysqld restart

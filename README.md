webdev-vagrant
==============

Creates a set of VirtualBox machines on your local machine pre-configured with Apache, PHP, MySQL.

Requirements
==============

VirtualBox version 4.2.4 or newer - https://www.virtualbox.org/wiki/Downloads
VirtualBox extensions - http://download.virtualbox.org/virtualbox/4.2.4/Oracle_VM_VirtualBox_Extension_Pack-4.2.4-81684.vbox-extpack
Vagrant version 1.0.5 or newer - http://vagrantup.com/
A 64bit-capable processor and operating system (OS X 10.6 or newer is fine)

Configuration details
==============

The VMs are running CentOS 6, Apache 2.2.15, MySQL 5.1, PHP 5.3.3.
The IUS repo is enabled, so newer versions of packages are available (i.e. MySQL 5.5).
The VMs are pre-configured to respond on the IP address range 10.10.10.0/24.
Apache is configured to serve up /server/htdocs by default.
The root password is 'vagrant'.
The 'vagrant' user is set to have full sudo rights.
The root user on the MySQL server is preconfigured and the credentials are stored in the vagrant user's .my.cnf, so you should be able to just run "mysql" as the vagrant user and be logged in on the MySQL console as root.
A default "squishydev" database is created with the username and password both set to "squishydev".
The directory containing the Vagrantfile config file on your machine is mounted on the virtual machine in "/vagrant" to facilitate moving files to and from the virtual machine.

Usage
==============

To start up the virtual machine, run "vagrant up" in the same directory as the Vagrantfile config file. As soon as it's booted you should be able to hit http://10.10.10.10 and see a placeholder index page.
To access the virtual machine, run "vagrant ssh".  That will log you into the virtual machine as the user "vagrant".
To shut the machine down, run "vagrant halt".  This gracefully shuts the machine down, retaining whatever changes you've made.
To delete the virtual machine, run "vagrant destroy".  This will completely erase the virtual machine and delete any changes you've made.

Basically, once you've run "vagrant up" the VM should only need you to check out your code in the VM's /server/htdocs directory and tell it what database credentials to use to have a functional dev site up and running.

Credits
==============
Huge chunks shamelessly stolen from a gist posted by David Lutz (https://github.com/dlutzy): https://gist.github.com/2469037/646a2b99656ef68eba87cec3ecec96d2d581f68d

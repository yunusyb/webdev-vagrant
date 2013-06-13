webdev-vagrant
==============

Creates a set of VirtualBox machines on your local machine pre-configured with Apache, PHP, MySQL.

Requirements
==============

* VirtualBox version 4.2.10 or newer - https://www.virtualbox.org/wiki/Downloads
* VirtualBox extensions 4.2.10 or newer - http://download.virtualbox.org/virtualbox/4.2.10
* Vagrant version 1.0.7 or newer - http://vagrantup.com/
* A 64bit-capable processor and operating system (OS X 10.6 or newer is fine)

Installation
=============

* Clone this repository.  It provides the root of a new project repository.
* Put your project webroot in the {reporoot}/htdocs directory
* We haven't included some required puppet modules.  We're working on how best to include them, but for now you'll want to do the following from the repository root:
<pre>
cd vagrant/modules
git clone git@github.com:puppetlabs/puppetlabs-apache.git apache
git clone git@github.com:ripienaar/puppet-concat.git concat
git clone git@github.com:stahnma/puppet-module-epel.git epel
git clone git@github.com:puppetlabs/puppetlabs-mysql.git mysql
git clone git@github.com:ezheidtmann/puppet-pear.git pear
</pre>

Configuration details
==============

* The VM is running CentOS 6, Apache 2.2.15, MySQL 5.1, PHP 5.3.3.
* The EPEL repo is enabled, so newer versions of packages are available.
* Apache is configured to serve up /server/htdocs by default.
* The root password is 'vagrant'.
* The 'vagrant' user is set to have full sudo rights.
* The root user on the MySQL server is preconfigured and the credentials are stored in the root user's .my.cnf, so you should be able to just run "sudo mysql" and be logged in on the MySQL console as root.
* The directory containing the Vagrantfile config file and the rest of this repository (including your project webroot) on your local machine is mounted on the virtual machine in "/server" to facilitate moving files to and from the virtual machine.

Usage
==============

* To start up the virtual machine, run "vagrant up" in the same directory as the Vagrantfile config file. As soon as it's booted you should be able to hit http://localhost:8080 and see whatever is in the {reporoot}/htdocs directory.
* To access the virtual machine, run "vagrant ssh".  That will log you into the virtual machine as the user "vagrant".
* To shut the machine down, run "vagrant halt".  This gracefully shuts the machine down, retaining whatever changes you've made.
* To delete the virtual machine, run "vagrant destroy".  This will completely erase the virtual machine and delete any changes you've made.

Basically, once you've run "vagrant up" the VM should only need you to check out your code in the VM's /server/htdocs directory and tell it what database credentials to use to have a functional dev site up and running.

Credits
==============
A big thanks to Evan Heidtmann (https://github.com/ezheidtmann) for taking my vague, badly-implemented idea and making it actually *work*.  The base box and most of the Puppet and configuration scripts are his work.

Huge chunks shamelessly stolen from a gist posted by David Lutz (https://github.com/dlutzy): https://gist.github.com/2469037/646a2b99656ef68eba87cec3ecec96d2d581f68d

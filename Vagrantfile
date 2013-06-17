#
# Squishymedia's Puppetized Vagrantfile
#

# GETTING STARTED
#
# Get your vm set up:
#   vagrant up
# Set up hosts file on your local machine:
#   127.0.0.1 projectname.local
# Sync the database (if using Drupal):
#   vagrant ssh
#   drush sql-sync @projectname-dev @projectname-local
# Sync uploaded files (if using Drupal):
#   drush rsync @projectname-dev:%files @projectname-local:%files
#
# Visit the site at http://projectname.local:3080/

# ------------------------------------

hostname = %x[ hostname -f ]
username = %x[ whoami ]

# You might want to replace this with a literal project name.
project  = File.basename(File.dirname(__FILE__));

Vagrant::Config.run do |config|
  config.vm.box_url = "https://911fc3b8b8cc070da44b-76fd772d1c308d2aec785b792582b337.ssl.cf2.rackcdn.com/Centos-6.4-x86_64_puppet_2013-06-11.box"
  config.vm.box = "Centos-6.4-x86_64_puppet_2013-06-11"
  config.vm.customize ["modifyvm", :id, "--memory", 1024]
  config.vm.customize ["modifyvm", :id, "--cpus", 2]

  # fix "read-only filesystem" errors in Mac OS X
  # see: https://github.com/mitchellh/vagrant/issues/713
  config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/server", "1"]

  # NFS mount needs hostonly net
  # Docs: http://docs-v1.vagrantup.com/v1/docs/host_only_networking.html
  config.vm.network :hostonly, "10.12.34.56"

  # Mount webroot
  config.vm.share_folder "server", "/server", ".", :nfs => true

  # Forward SSH key agent over the 'vagrant ssh' connection
  config.ssh.forward_agent = true

  # Enable to launch a VirtualBox console
  #cnf.vm.boot_mode = :gui

  config.vm.host_name = "web.%s.%s" % [ project, hostname.strip.to_s ]

  # Ensure a few basic packages are installed.
  #
  # This was an attempt at speeding up the first install due to puppet's habit
  # of running yum once for each package. But in practice, the first
  # provisioning is quicker without this script.
  #config.vm.provision :shell, :path => 'vagrant/packages.sh'

  # Docs: http://docs-v1.vagrantup.com/v1/docs/provisioners/puppet.html
  config.vm.provision :puppet do |puppet|
    # Load puppet manifests from vagrant/manifests
    puppet.manifests_path = "vagrant/manifests"
    puppet.manifest_file  = "default.pp"
    puppet.module_path    = "vagrant/modules"
    # Set $vagrant = 1 inside puppet manifests
    puppet.facter = {
      "vagrant" => "1",
      "vagrant_ssh_user" => username.strip.to_s,
    }
    puppet.options = "--hiera_config /server/vagrant/hiera.yaml"
    # Send "notice" to syslog
    puppet.options = "--logdest syslog"
    # Enable this to see the details of a puppet run
    #puppet.options = "--verbose --debug"
  end

  # A few things still need to be done after puppet.
  config.vm.provision :shell, :path => 'vagrant/setup.sh', :args => project

  config.vm.forward_port 80,   8080
  config.vm.forward_port 3306, 8006
end

# vim: set ft=ruby

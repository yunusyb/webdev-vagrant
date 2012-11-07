# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

config.vm.box_url = "https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box"
config.vm.box = "centos-minimal"

# Uncomment to boot boxes with a GUI so you can see 
#  startup. The default is headless.
#config.vm.boot_mode = :gui

# Puppet configs
config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path    = "modules"
    puppet.manifest_file  = "default.pp"
    #puppet.options        = "--verbose --debug"
end

config.vm.provision :shell do |shell|
    shell.inline = "/vagrant/install.sh"
end

# Web server #1
  config.vm.define :web1 do |web1_config|
    web1_config.vm.box = "centos-minimal"
    web1_config.vm.network :hostonly, "10.10.10.11"
    web1_config.vm.host_name = "web1.squishyclients.net"
    web1_config.vm.share_folder "webroot", "/server", "www"
  end

# Web server #2
#  config.vm.define :web2 do |web2_config|
#    web2_config.vm.box = "centos-minimal"
#    web2_config.vm.network :hostonly, "10.10.10.12"
#    web2_config.vm.host_name = "web2.squishyclients.net"
#    web2_config.vm.share_folder "webroot", "/server", "www"
#  end

# Database server #1
  config.vm.define :db1 do |db1_config|
    db1_config.vm.box = "centos-minimal"
    db1_config.vm.network :hostonly, "10.10.10.21"
    db1_config.vm.host_name = "db1.squishyclients.net"
  end

# Database server #2
#  config.vm.define :db2 do |db2_config|
#    db2_config.vm.box = "centos-minimal"
#    db2_config.vm.network :hostonly, "10.10.10.22"
#    db2_config.vm.host_name = "db2.squishyclients.net"
#  end
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

config.vm.box_url = "https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box"
config.vm.box = "centos-minimal"
config.vm.customize ["modifyvm", :id, "--memory", 512]

# Uncomment to boot boxes with a GUI so you can see 
#  startup. The default is headless.
#config.vm.boot_mode = :gui

# Install EPEL before puppet runs
config.vm.provision :shell do |shell|
    shell.inline = "/vagrant/install.sh"
end

# Puppet configs
config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path    = "modules"
    puppet.manifest_file  = "default.pp"
    #puppet.options        = "--verbose --debug"
end

# We're only doing one server here
config.vm.network :hostonly, "10.10.10.10"
config.vm.host_name = "dev1.squishyclients.net"
#config.vm.share_folder "webroot", "/server", "www"

end

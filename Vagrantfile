# vim: set ft=ruby :

# Box list
boxes = [
	{ :name => :web0,     :role => 'web',     :ip => '10.10.10.10' },
	#{ :name => :web1,     :role => 'web',     :ip => '10.10.10.11' },
	#{ :name => :web2,     :role => 'web',     :ip => '10.10.10.12' },
	{ :name => :database1,   :role => 'db',      :ip => '10.10.10.13' },
	#{ :name => :database2,   :role => 'db',      :ip => '10.10.10.14' },
	#{ :name => :cache1,     :role => 'cache',     :ip => '10.10.10.15' },
]

# Grab local hostname
hostname = %x[ hostname ]

Vagrant::Config.run do |config|
	# define defaults used on all boxes
	vm_default = proc do |cnf|
		cnf.vm.box_url = "https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box"
		cnf.vm.box = "centos-minimal"
		cnf.vm.customize ["modifyvm", :id, "--memory", 512]
		# Uncomment to boot boxes with a GUI so you can see 
		#  startup. The default is headless.
		#cnf.vm.boot_mode = :gui
	end

	boxes.each do |opts|
		config.vm.define opts[:name] do |config|
			# Set up default options
			vm_default.call(config)

			# Configure network, etc.
			#if this is a webnode, map port 8080 to port 80
			if opts[:role] == "web"
				config.vm.forward_port 80, 8080, :auto => true
				config.vm.customize ["modifyvm", :id, "--cpus", 2]
			end
			#
			# Set the hostname
			config.vm.host_name = "%s.%s" % [ opts[:name].to_s, hostname.strip.to_s ]
			#config.vm.host_name = "%s.vm" % hostname.strip.to_s
			config.vm.network :hostonly, opts[:ip]
			#config.vm.share_folder opts[:share_folder] if opts[:share_folder]

			# Install and configure all the things!
			config.vm.provision :shell do |shell|
				shell.inline = "/vagrant/install.sh"
			end
		end
	end

	# Puppet configs
	#config.vm.provision :puppet do |puppet|
	#    puppet.manifests_path = "manifests"
	#    puppet.module_path    = "modules"
	#    puppet.manifest_file  = "default.pp"
	#    puppet.options        = "--verbose --debug"
	#end

end

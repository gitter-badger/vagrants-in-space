vagrant_dir = File.expand_path(File.dirname(__FILE__))

Vagrant.configure("2") do |config|
	# Create a machine based on Debian Jessie and run setup.sh
	config.vm.box = "debian/jessie64"
	config.vm.provision :shell, path: "setup.sh"

	config.vm.provider :virtualbox do |v|
		# Set CPU and memory to mimic the lowest configuration on DigitalOcean
		v.memory = 512
		v.cpus = 1
		# Set the name of the machine within VirtualBox to the parent directory
		## To customize you can rename the parent directory or specify here like so: v.name = "My Vagrant Machine"
		v.name = File.basename(Dir.pwd)
		# No need for audio
		v.customize ["modifyvm", :id, "--audio", "none"]
	end

	config.ssh.forward_agent = true

	if defined?(VagrantPlugins::HostsUpdater)
		# Update hosts file to forward .dev domain to vm's private IP
		paths = Dir[File.join(vagrant_dir, 'config', '**', 'hosts')]
		hosts = paths.map do |path|
			lines = File.readlines(path).map(&:chomp)
			lines.grep(/\A[^#]/)
		end.flatten.uniq

		config.hostsupdater.aliases = hosts
		config.hostsupdater.remove_on_suspend = true
	end

	# Assiging a private IP address for hostsupdater to use
	## Change the subnet if you're running more than one virtual machine at once
	config.vm.network :private_network, ip: "192.168.50.5"

	# Sync folders
	## Not necessary to sync the root folder
	config.vm.synced_folder '.', '/vagrant', disabled: true
	## Syncs the config directory so that setup.sh can update the Nginx configuration from within the Vagrant machine
	config.vm.synced_folder "config/", "/home/vagrant/config"
	## Syncing the /user directory because typically you don't touch anything else in a Grav install
	config.vm.synced_folder "user/", "/var/www/html/user", :create => true, :group => "www-data", :owner => "www-data", :mount_options => [ "dmode=775", "fmode=774" ]
end

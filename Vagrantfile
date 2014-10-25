# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

domain = "example.com"

boxes = [
	{ :name => 'os-db-01',		:role => 'os-db',			:management_ip => '10.0.0.12', :cpus => 1, :memory =>  512 },
	{ :name => 'os-ctrl-01',	:role => 'os-controller',	:management_ip => '10.0.0.11', :cpus => 1, :memory => 2048 },
	{ :name => 'os-neutron-01',	:role => 'os-network',		:management_ip => '10.0.0.21', :cpus => 1, :memory =>  512, :tunnel_ip => '10.0.1.21', :external_net => true },
	{ :name => 'os-nova-01', 	:role => 'os-compute',		:management_ip => '10.0.0.31', :cpus => 2, :memory => 2048, :tunnel_ip => '10.0.1.31' },
	{ :name => 'os-nova-02',	:role => 'os-compute',		:management_ip => '10.0.0.41', :cpus => 2, :memory => 2048, :tunnel_ip => '10.0.1.41' },
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	unless Vagrant.has_plugin?("vagrant-hosts")
		raise 'Plugin not found. Run: vagrant plugin install vagrant-hosts'
	end
	if Vagrant.has_plugin?("vagrant-cachier")
		config.cache.scope = :box
		config.cache.enable :yum
	else
		puts "[-] WARN: This would be much faster if you ran 'vagrant plugin install vagrant-cachier' first"
	end

	boxes.each do |opts|
		config.vm.define opts[:name] do |config|
			config.vm.box = "ntbc-oel7"
			# Following doesn't work so use: vagrant box add ntbc-oel65 https://www.dropbox.com/l/aWt8kMbMXJqdGFNEXPncXo
			#config.vm.box_url = "https://www.dropbox.com/l/aWt8kMbMXJqdGFNEXPncXo"
			config.vm.hostname = "#{opts[:name]}.#{domain}"
			config.vm.network :private_network, ip: opts[:management_ip]
			if opts[:tunnel_ip] 
				config.vm.network :private_network, ip: opts[:tunnel_ip]
			end
			config.vm.provider "virtualbox" do |vb|
				vb.name = opts[:name]
				vb.customize ["modifyvm", :id, "--ioapic", "on"]
		        vb.customize ["modifyvm", :id, "--memory", opts[:memory]] if opts[:memory]
		        vb.customize ["modifyvm", :id, "--cpus", opts[:cpus]] if opts[:cpus]
				if opts[:external_net]
					vb.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
				end
			end
			config.vm.synced_folder "root/.ssh", "/root/.ssh", owner: "root", group: "root"
			config.vm.provision :hosts
			config.vm.provision :shell, :path => 'common.sh'

			#Fix for Ansible bug resulting in an encoding error
			ENV['PYTHONIOENCODING'] = "utf-8"
			config.vm.provision "ansible" do |ansible|
				ansible.limit = "#{opts[:role]}"
				ansible.playbook = "ansible/openstack.yml"
				ansible.inventory_path = "ansible/hosts"
			end
	    end
	end
end

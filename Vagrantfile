# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

# Variables
params = YAML.load_file 'config/vagrant.yml'
var_box            = params['box']
var_vm_name        = params['vm_name']
var_mem_size       = params['mem_size']
var_cpus           = params['cpus']
var_public_ip1     = params['public_ip1']
var_public_ip2     = params['public_ip2']
var_non_rotational = params['non_rotational']
var_hostname       = params['hostname']

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = var_box

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  #config.vm.network "forwarded_port", guest: 8080, host: 8080
  #config.vm.network "forwarded_port", guest: 8443, host: 8443
  #config.vm.network "forwarded_port", guest: 1521, host: 15021
  #config.vm.network "forwarded_port", guest: 5500, host: 5500
  #config.vm.network "forwarded_port", guest: 5432, host: 15432

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"



  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  #config.vm.network "public_network"



  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #

  # Create 2 DB nodes, primary and standby
      #Primary DB server
      config.vm.define "primary" do |primary|
        primary.vm.hostname = "primarydb"
        #primary.vm.box = var_box
        primary.vm.network :private_network, ip: var_public_ip1
      end

      #Standby DB server
      config.vm.define "standby" do |standby|
        standby.vm.hostname = "standbydb"
        #standby.vm.box = var_box
        standby.vm.network :private_network, ip: var_public_ip2
      end

      config.vm.provider "virtualbox" do |vb|
        vb.memory = var_mem_size
        vb.cpus   = var_cpus
        #vb.name   = var_vm_name#{i}
        
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '0', '--nonrotational', var_non_rotational]
      end
  

  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    sh /vagrant/scripts/setup.sh
  SHELL

end

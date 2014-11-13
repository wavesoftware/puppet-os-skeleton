#!/usr/bin/env ruby

Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/trusty64"

  domain      = 'vagrant.dev'
  masterhost  = "#{:master}.#{domain}"
  branch      = `git rev-parse --abbrev-ref HEAD`.chop()
  environment = branch.gsub /[^0-9A-Za-z]/, '_'
  debug_flag  = unless ENV['PUPPET_VERBOSE'].nil? then '--debug --trace' else '' end
  args        = [ '/vagrant', environment, masterhost ]

  config.vm.network "private_network", type: "dhcp"

  # Enable landrush local DNS server
  config.landrush.enabled = true

  # Puppet master node configuration
  config.vm.define :master do |master|
    # Initial setup of puppet master and repo sync using r10k
    master.vm.provision "shell", path: "src/bash/master.sh", args: args
    # Development only! Autosigning of nodes.
    master.vm.provision "shell", path: "src/bash/internal/master-autosign.sh" 
    # Setting a hostname
    master.vm.hostname = masterhost

    # Provider configuration
    master.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 1
    end

    # A puppet server provision
    master.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = masterhost
      puppet.options = "-t --environment '#{environment}' #{debug_flag}"
    end
  end

  # Puppet node configuration
  name = :slave1
  config.vm.define name do |slave|
    # Initial setup of puppet node
    slave.vm.provision "shell", path: "src/bash/agent.sh", args: args
    # Setting a host name
    slave.vm.hostname = "#{name}.#{domain}"

    # A puppet server provision
    slave.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = masterhost
      puppet.options = "-t --environment '#{environment}' #{debug_flag}"
    end

    # Provider configuration
    slave.vm.provider "virtualbox" do |v|
      v.memory = 256
      v.cpus = 1
    end
  end

  name = :slave2
  # Puppet node configuration
  config.vm.define name do |slave|
    # Initial setup of puppet node
    slave.vm.provision "shell", path: "src/bash/agent.sh", args: args
    # Setting a host name
    slave.vm.hostname = "#{name}.#{domain}"

    # A puppet server provision
    slave.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = masterhost
      puppet.options = "-t --environment '#{environment}' #{debug_flag}"
    end

    # Provider configuration
    slave.vm.provider "virtualbox" do |v|
      v.memory = 256
      v.cpus = 1
    end
  end

end
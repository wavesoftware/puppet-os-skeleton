#!/usr/bin/env ruby

Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/trusty64"

  masterhost  = "master.localdomain"
  branch      = `git rev-parse --abbrev-ref HEAD`.chop()
  environment = branch.gsub /[^0-9A-Za-z]/, '_'
  debug_flag  = if ENV['PUPPET_VERBOSE'] != '' then '--debug --trace' else '' end
  args        = [ '/vagrant', environment, masterhost ]

  config.vm.network "private_network", type: "dhcp"
  config.landrush.enabled = true

  config.vm.define "master" do |master|
    master.vm.provision "shell", path: "src/bash/master.sh", args: args
    master.vm.provision "shell", path: "src/bash/master-autosign.sh"
    master.vm.hostname = masterhost

    master.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 1
    end

    master.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = masterhost
      puppet.options = "-t --environment '#{environment}' #{debug_flag}"
    end
  end

  config.vm.define "slave1" do |slave|
    slave.vm.provision "shell", path: "src/bash/agent.sh", args: args
    slave.vm.hostname = "slave1.localdomain"

    slave.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = masterhost
      puppet.options = "-t --environment '#{environment}' #{debug_flag}"
    end

    slave.vm.provider "virtualbox" do |v|
      v.memory = 256
      v.cpus = 1
    end
  end

  config.vm.define "slave2" do |slave|
    slave.vm.provision "shell", path: "src/bash/agent.sh", args: args
    slave.vm.hostname = "slave2.localdomain"

    slave.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = masterhost
      puppet.options = "-t --environment '#{environment}' #{debug_flag}"
    end

    slave.vm.provider "virtualbox" do |v|
      v.memory = 256
      v.cpus = 1
    end
  end

  config.vm.define "slave3" do |slave|
    slave.vm.provision "shell", path: "src/bash/agent.sh", args: args
    slave.vm.hostname = "slave3.localdomain"

    slave.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = masterhost
      puppet.options = "-t --environment '#{environment}' #{debug_flag}"
    end

    slave.vm.provider "virtualbox" do |v|
      v.memory = 256
      v.cpus = 1
    end
  end

  config.vm.define "slave4" do |slave|
    slave.vm.provision "shell", path: "src/bash/agent.sh", args: args
    slave.vm.hostname = "slave4.localdomain"

    slave.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = masterhost
      puppet.options = "-t --environment '#{environment}' #{debug_flag}"
    end

    slave.vm.provider "virtualbox" do |v|
      v.memory = 256
      v.cpus = 1
    end
  end

end
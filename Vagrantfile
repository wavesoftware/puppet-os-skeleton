#!/usr/bin/env ruby

Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/trusty64"

  masterhost  = "master.localdomain"
  branch      = `git rev-parse --abbrev-ref HEAD`.chop()
  environment = branch.gsub /[^0-9A-Za-z]/, '_'
  debug_flag  = if ENV['PUPPET_VERBOSE'] == 'debug' then '--debug --trace' else '' end
  args        = [ '/vagrant', environment ]

  config.vm.network "private_network", type: "dhcp"

  config.vm.define "master" do |master|
    master.vm.provision "shell", path: "src/bash/master.sh", args: args
    master.vm.hostname = masterhost

    master.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = masterhost
      puppet.options = "--environment '#{environment}' #{debug_flag}"
    end
  end

  config.vm.define "slave" do |slave|
    slave.vm.provision "shell", path: "src/bash/agent.sh", args: args
    slave.vm.hostname = "slave.localdomain"

    slave.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = masterhost
      puppet.options = "--environment '#{environment}' #{debug_flag}"
    end
  end

end
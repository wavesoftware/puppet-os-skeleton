#!/usr/bin/env ruby

Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/trusty64"

  $masterhost = "master.localdomain"

  config.vm.network "private_network", type: "dhcp"

  config.vm.define "master" do |master|
    master.vm.provision "shell", path: "src/bash/master.sh"
    master.vm.hostname = $masterhost

    master.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = $masterhost
    end
  end

  config.vm.define "slave" do |slave|
    slave.vm.provision "shell", path: "src/bash/agent.sh"
    slave.vm.hostname = "slave.localdomain"

    slave.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = $masterhost
    end
  end

end
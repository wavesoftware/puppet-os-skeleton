#!/usr/bin/env ruby

require_relative "src/ruby/vagrant/defines"

$global = {}
$global[:domain]      = 'vagrant.dev'
$global[:masterhost]  = "#{:master}.#{$global[:domain]}"
$global[:environment] = `git rev-parse --abbrev-ref HEAD`.chop().gsub /[^0-9A-Za-z]/, '_'
$global[:debug_flag]  = unless ENV['PUPPET_VERBOSE'].nil? then '--debug --trace' else '' end
$global[:args]        = [ '/vagrant', $global[:environment], $global[:masterhost] ]

Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", type: "dhcp"

  # Enable landrush local DNS server
  config.landrush.enabled = true

  # Puppet master node configuration
  config.vm.define_master vmsize(1024, 1)

  # Puppet node configuration
  config.vm.define_agent :slave1, vmsize(256, 1)

  # Puppet node configuration
  config.vm.define_agent :slave2, vmsize(256, 1)

end
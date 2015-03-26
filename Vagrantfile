#!/usr/bin/env ruby

require_relative "src/ruby/vagrant/defines"

$global = {}
$global[:domain]      = 'vagrant.dev'
$global[:masterhost]  = "#{:master}.#{$global[:domain]}"
$global[:environment] = `git rev-parse --abbrev-ref HEAD`.chop().gsub /[^0-9A-Za-z]/, '_'
$global[:debug_flag]  = unless ENV['PUPPET_VERBOSE'].nil? then '--debug --trace' else '' end
$global[:repopath]    = '/vagrant'

Vagrant.configure("2") do |config|
  
  # Sets box to minimal Ubuntu Server 14.04.1 x86_64 
  # Box is clean, without configuration management
  # Box is valid for virtualbox and libvirt providers
  config.vm.box = "puppetlabs/ubuntu-14.04-64-nocm"

  # Enable landrush local DNS server
  config.landrush.enabled = true

  # Puppet master node configuration (1024m ram, 1 cpu)
  config.vm.define_master vmsize(1024, 1)

  # Puppet node configuration (256m ram, 1 cpu)
  config.vm.define_agent :slave1, vmsize(256, 1)

  # Puppet node configuration (256m ram, 1 cpu)
  config.vm.define_agent :slave2, vmsize(256, 1)

end

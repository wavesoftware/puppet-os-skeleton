#!/usr/bin/env ruby

require "vagrant"

def vmsize memory, cpus
	return {
		:memory => memory,
		:cpus   => cpus
	}
end

module VagrantPlugins
	module Kernel_V2
		class VMConfig < Vagrant.plugin("2", :config)

			# Defines a puppet master
			def define_master size
				define :master do |master|
					# Initial setup of puppet master and repo sync using r10k
					master.vm.provision "shell", path: "src/bash/master.sh", args: $global[:args]
					# Development only! Autosigning of nodes.
					master.vm.provision "shell", path: "src/bash/internal/master-autosign.sh" 
					# Setting a hostname
					master.vm.hostname = $global[:masterhost]

					# Provider configuration
					master.vm.provider "virtualbox" do |v|
						v.memory = size[:memory]
						v.cpus   = size[:cpus]
					end

					# A puppet server provision
					master.vm.provision "puppet_server" do |puppet|
						puppet.puppet_server = $global[:masterhost]
						puppet.options       = "-t --environment '#{$global[:environment]}' #{$global[:debug_flag]}"
					end
				end
			end

			# Defines a puppet agent
			def define_agent name, size
				define name do |slave|
					# Initial setup of puppet node
					slave.vm.provision "shell", path: "src/bash/agent.sh", args: $global[:args]
					# Setting a host name
					slave.vm.hostname = "#{name}.#{$global[:domain]}"

					# Provider configuration
					slave.vm.provider "virtualbox" do |v|
						v.memory = size[:memory]
						v.cpus   = size[:cpus]
					end

					# A puppet server provision
					slave.vm.provision "puppet_server" do |puppet|
						puppet.puppet_server = $global[:masterhost]
						puppet.options       = "-t --environment '#{$global[:environment]}' #{$global[:debug_flag]}"
					end
				end
			end
		end
	end
end
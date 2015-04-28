# Exchange hostnames with PuppetDB
class common::hosts::exchange {

	include stdlib::stages

	class selfhost {
		if $::fqdn_ipaddress != unset {
			@@host { $::fqdn:
				host_aliases => $::hostname,
				ip           => $::fqdn_ipaddress,
				tag          => 'hosts-exchange',
			}
		}
	}

	class { 'selfhost': 
		stage   => 'setup',
	}

	Host <<| tag == 'hosts-exchange' |>>
}
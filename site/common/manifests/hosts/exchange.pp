# Exchange hostnames with PuppetDB
class common::hosts::exchange {

	include common::stages

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
		stage   => 'before',
	}

	Host <<| tag == 'hosts-exchange' |>>
}
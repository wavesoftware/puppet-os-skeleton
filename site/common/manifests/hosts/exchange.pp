class common::hosts::exchange {
	
	@@host { $::fqdn:
		host_aliases => $::hostname,
		ip           => $::ipaddress,
		tag          => 'hosts-exchange',
	}

	Host <<| tag == 'hosts-exchange' |>>
}
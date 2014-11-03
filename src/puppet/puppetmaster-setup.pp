#!/usr/bin/env puppet

file { '/etc/puppet/hiera.conf':
  ensure => 'file',
  source => '/vagrant/src/hiera/hiera.conf',
}

file { '/etc/hiera.conf':
  ensure => 'link',
  target => '/etc/puppet/hiera.conf',
}

file { '/var/lib/hiera':
  ensure   => 'directory',
  source   => '/vagrant/src/hiera/data',
  recurse  => true,
}

package { [ 'ruby', 'ruby-dev', 'git' ]: ensure => 'installed', }

package { ['librarian-puppet', 'r10k']:
  ensure   => 'installed',
  provider => 'gem',
  require  => Package['ruby', 'ruby-dev', 'git'],
}

file { '/etc/puppet/Puppetfile':
  source => '/vagrant/src/Puppetfile',
}

exec { 'librarian-puppet update --verbose':
  alias       => 'librarian-puppet',
  path        => $::path,
  cwd         => '/etc/puppet',
  refreshonly => true,
  require     => Package['librarian-puppet'],
  subscribe   => File['/etc/puppet/Puppetfile'],
}

file { '/etc/puppet/manifests/site.pp':
  ensure  => 'file',
  content => "
node 'master.localdomain' {
  include roles::master
}
node 'slave.localdomain' {
  include roles::slave
}
  ",
}

augeas { '/etc/puppet/puppet.conf':
  context => '/files//etc/puppet/puppet.conf',
  changes => [
    'set main/show_diff true',
    "set main/server ${::fqdn}",
  ],
}

/*
include puppetdb
include puppetdb::master::config

Exec['librarian-puppet'] -> Class['puppetdb']
*/
/*

@@host { $::fqdn:
  host_aliases => $::hostname,
  ip           => $::ipaddress,
}

Host <<| |>>
*/
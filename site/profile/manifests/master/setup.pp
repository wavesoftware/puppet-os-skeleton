#!/usr/bin/env puppet

package { 'git': ensure => 'installed', }

package { 'r10k':
  ensure   => 'installed',
  provider => 'gem',
  require  => Package['git'],
}

file { '/etc/r10k.yaml':
  ensure  => 'file',
  source  => '/vagrant/src/r10k.yaml',
}

exec { 'r10k deploy environment -v':
  path        => $::path,
  require     => [
    File['/etc/r10k.yaml'],
    Package['r10k'],
    Augeas['/etc/puppet/puppet.conf'],
    File['/etc/puppet/hiera.yaml'],
    File['/etc/hiera.yaml'],
  ],
}

augeas { '/etc/puppet/puppet.conf':
  context => '/files//etc/puppet/puppet.conf',
  changes => [
    'set main/show_diff true',
    "set main/server ${::fqdn}",
  ],
}


file { '/etc/puppet/hiera.yaml':
  ensure => 'file',
  source => '/vagrant/src/hiera.yaml',
}

file { '/etc/hiera.yaml':
  ensure => 'link',
  target => '/etc/puppet/hiera.yaml',
}

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
  refreshonly => true,
  subscribe   => [
    File['/etc/r10k.yaml'],
    Package['r10k'],
    Augeas['/etc/puppet/puppet.conf'],
    File['/etc/puppet/hiera.conf'],
    File['/etc/hiera.conf'],
  ],
}

augeas { '/etc/puppet/puppet.conf':
  context => '/files/etc/puppet/puppet.conf',
  changes => [
    'set main/show_diff true',
    "set agent/server ${::fqdn}",
    'set agent/classfile $vardir/classes.txt',
    'set agent/localconfig $vardir/localconfig',
  ],
}

service { 'puppetmaster':
  ensure    => 'running',
  enable    => true,
  subscribe => Augeas['/etc/puppet/puppet.conf'],
}

file { '/etc/puppet/hiera.conf':
  ensure => 'file',
  source => '/vagrant/src/hiera.conf',
}

file { '/etc/hiera.conf':
  ensure => 'link',
  target => '/etc/puppet/hiera.conf',
}

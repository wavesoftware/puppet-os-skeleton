#!/usr/bin/env puppet

class profile::master::setup {

  package { 'git': ensure => 'installed', }

  package { ['r10k', 'librarian-puppet']:
    ensure   => 'installed',
    provider => 'gem',
    require  => Package['git'],
  }

  Exec {
    path => $::path,
  }

  file { '/etc/r10k.yaml':
    ensure  => 'file',
    source  => '/vagrant/src/r10k.yaml',
  }

  exec { 'r10k deploy environment -v':
    refreshonly => true,
    subscribe   => [
      File['/etc/r10k.yaml'],
      Package['r10k'],
      Augeas['/etc/puppet/puppet.conf'],
      File['/etc/puppet/hiera.yaml'],
      File['/etc/hiera.yaml'],
    ],
  }

  augeas { '/etc/puppet/puppet.conf':
    context => '/files/etc/puppet/puppet.conf',
    changes => [
      'set main/environmentpath $confdir/environments',
      'set main/show_diff true',
      "set agent/server ${::fqdn}",
      'set agent/classfile $vardir/classes.txt',
      'set agent/localconfig $vardir/localconfig',
      'set main/modulepath /etc/puppet/environments/$environment/modules:/etc/puppet/environments/$environment/site',
      'set main/manifest /etc/puppet/environments/$environment/site.pp',
    ],
    require => Exec['install-and-update-os'],
  }

  file { '/var/lib/puppet/state/agent_disabled.lock':
    ensure => 'absent',
    notify => Service['puppetmaster'],
  }

  $deb      = "puppetlabs-release-${::lsbdistcodename}"
  $debfile  = "${deb}.deb"
  $srcdir   = '/usr/src'
  $debpath  = "${srcdir}${deb}"

  exec { "wget https://apt.puppetlabs.com/${deb}":
    cwd     => $srcdir,
    creates => $debpath,
  }

  exec { "dpkg -iv $debpath && apt-get update":
    alias   => 'install-and-update-os',
    unless  => 'dpkg -l | grep -q \'ii  time\'',
    require => Exec["wget https://apt.puppetlabs.com/${deb}"],
  }

  service { 'puppetmaster':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => Augeas['/etc/puppet/puppet.conf'],
  }

  file { '/etc/puppet/hiera.yaml':
    ensure => 'file',
    source => '/vagrant/src/hiera.yaml',
  }

  file { '/etc/hiera.yaml':
    ensure => 'link',
    target => '/etc/puppet/hiera.yaml',
  }
}
include profile::master::setup
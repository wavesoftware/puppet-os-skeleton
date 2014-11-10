#!/usr/bin/env puppet

class profile::master::setup {

  if ! $::repopath {
    fail('Set $::repopath facter value!')
  }

  package { 'git': 
    ensure => 'installed', 
  }

  package { 'r10k':
    ensure   => 'installed',
    provider => 'gem',
    require  => Package['git'],
  }

  Exec {
    path      => $::path,
    logoutput => true,
  }

  file { '/etc/r10k.yaml':
    ensure  => 'file',
    source  => "${::repopath}/src/r10k.yaml",
  }

  exec { 'git add -A && git write-tree > /etc/puppet/repo.hash':
    alias  => 'check-input-repo',
    cwd    => $::repopath,
    onlyif => '[ ! -f /etc/puppet/repo.hash ] || test `git add -A && git write-tree` != `cat /etc/puppet/repo.hash`'
  }

  exec { 'r10k deploy environment -p -v':
    refreshonly => true,
    subscribe   => [
      Exec['check-input-repo'],
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
  }

  file { '/var/lib/puppet/state/agent_disabled.lock':
    ensure => 'absent',
    notify => Service['puppetmaster'],
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
    source => "${::repopath}/src/hiera.yaml",
  }

  file { '/etc/hiera.yaml':
    ensure => 'link',
    target => '/etc/puppet/hiera.yaml',
  }
}
include profile::master::setup
# Base profile - active on all nodes
class profile::base {
  include ntp
  include common::filebucket
  include common::puppet::agent
  include common::packages
  include stdlib::stages
  include common::environment
}

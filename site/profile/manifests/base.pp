class profile::base {
  include ntp
  include common::filebucket
  include common::puppet::agent
}

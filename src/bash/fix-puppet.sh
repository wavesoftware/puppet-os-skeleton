#!/bin/bash

set -e
set -x

puppet resource augeas puppet.conf context=/files/etc/puppet/puppet.conf changes='rm main/templatedir'
puppet resource file '/var/lib/puppet/state/agent_disabled.lock' ensure=absent
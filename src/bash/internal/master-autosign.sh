#!/bin/bash

set -e

# Enable autosign for nodes - should be run only on development boxes!

puppet resource file /etc/puppet/autosign.conf ensure=file content="*.$(facter domain)"
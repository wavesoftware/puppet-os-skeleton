#!/bin/bash

set -e
set -x

puppet resource file /etc/puppet/autosign.conf ensure=file content='*.localdomain'
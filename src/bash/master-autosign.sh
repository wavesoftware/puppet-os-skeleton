#!/bin/bash

set -x
set -e

puppet resource file /etc/puppet/autosign.conf ensure=file content='*.localdomain'
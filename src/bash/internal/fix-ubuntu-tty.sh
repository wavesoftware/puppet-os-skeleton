#!/bin/sh

set -e

sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile
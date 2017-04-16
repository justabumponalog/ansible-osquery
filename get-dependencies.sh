#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

if [ $# != 0 ]; then
rolesdir=$1
else
rolesdir=$(dirname $0)/..
fi

#[ ! -d $rolesdir/juju4.redhat-epel ] && git clone https://github.com/juju4/ansible-redhat-epel $rolesdir/juju4.redhat-epel
## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/kbrebabnov.osquery ] && ln -s ansible-myrole $rolesdir/kbrebabnov.osquery
[ ! -e $rolesdir/kbrebabnov.osquery ] && cp -R $rolesdir/ansible-myrole $rolesdir/kbrebabnov.osquery

## don't stop build on this script return code
true


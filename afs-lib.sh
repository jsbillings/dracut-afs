#!/usr/bin/sh

# afs_to_var AFSROOT
# use AFSROOT to set $cell, $volume, and $vlservers
# AFSROOT is something like: afs://cellname:volumename:vlserver1:vlserver2:vlserver3
# NETIF is used to get information from DHCP options, if needed.

type getarg > /dev/null 2>&1 || . /lib/dracut-lib.sh

afs_to_var() {
    local afscell
    local afsvolume
    # Check required arguments
    afscell=${1##afs://}
    cell=${afscell%%:*}
    # shellcheck disable=SC2034
    afsvolume=${afscell#*:}
    # shellcheck disable=SC2034
    vlservers=${afsvolume#*:}
    volume=${afsvolume%%:*}
}

#!/usr/bin/sh
#
# root=afs://cell:volume:vlserver1:vlserver2:vlserver3
#
# This syntax can come from DHCP root-path as well.
#

type getarg > /dev/null 2>&1 || . /lib/dracut-lib.sh
. /lib/afs-lib.sh

# This script is sourced, so root should be set. But let's be paranoid
[ -z "$root" ] && root=$(getarg root=)

if [ -z "$netroot" ]; then
    for netroot in $(getargs netroot=); do
        [ "${netroot%%:*}" = "afs" ] && break
    done
    [ "${netroot%%:*}" = "afs" ] || unset netroot
fi

# Root takes precedence over netroot
if [ "${root%%:*}" = "afs" ]; then
    if [ -n "$netroot" ]; then
        warn "root takes precedence over netroot. Ignoring netroot"
    fi
    netroot=$root
    unset root
fi

# If it's not afs we don't continue
[ "${netroot%%:*}" = "afs" ] || return

# Check required arguments
afs_to_var "$netroot"

# If we don't have a server, we need dhcp
if [ -z "$server" ]; then
    # shellcheck disable=SC2034
    DHCPORSERVER="1"
fi

# Done, all good!
# shellcheck disable=SC2034
rootok=1

# shellcheck disable=SC2016
echo '[ -e $NEWROOT/proc ]' > "$hookdir"/initqueue/finished/afsroot.sh

#!/usr/bin/sh

type getarg > /dev/null 2>&1 || . /lib/dracut-lib.sh
. /lib/afs-lib.sh

[ "$#" = 3 ] || exit 1

# root is in the form root=afs://cellname:volumename:vlservers either from
# cmdline or dhcp root-path
#netif="$1"
root="$2"
NEWROOT="$3"

afs_to_var "$root"

# Set up kAFS cell with provided cell info
modprobe kafs
info "Sleeping for 2 seconds for network to come up"
sleep 2
info "Using these parameters: add $cell $vlservers" 
printf "add $cell $vlservers" > /proc/fs/afs/cells

# shellcheck disable=SC2154
mount -t afs "#${cell}:${volume}" "$NEWROOT" && { [ -e /dev/root ] || ln -s null /dev/root; }

# inject new exit_if_exists
# shellcheck disable=SC2016
# shellcheck disable=SC2154
echo 'settle_exit_if_exists="--exit-if-exists=/dev/root"; rm -f -- "$job"' > "$hookdir"/initqueue/afs.sh
# force udevsettle to break
: > "$hookdir"/initqueue/work

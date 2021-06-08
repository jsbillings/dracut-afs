#!/usr/bin/bash

# called by dracut
check() {
    # If our prerequisites are not met, fail anyways.
    [[ $hostonly ]] || [[ $mount_needs ]] && {
        for fs in "${host_fs_types[@]}"; do
            [[ $fs == "afs" ]] && return 0
        done
        return 255
    }

    return 0
}

# called by dracut
depends() {
    # We depend on network modules being loaded
    echo network
}

# called by dracut
installkernel() {
    instmods rxrpc kafs
}

# called by dracut
install() {
    inst_hook cmdline 90 "$moddir/parse-afsroot.sh"
    inst "$moddir/afsroot.sh" "/sbin/afsroot"
    inst "$moddir/afs-lib.sh" "/lib/afs-lib.sh"
    dracut_need_initqueue
}

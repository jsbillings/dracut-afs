# dracut-afs
Dracut module to support AFS root, using the in-kernel kAFS module

This module supports using an AFS volume for a root filesystem.

The syntax is this:

    root=afs://<AFS cell name>:<AFS volume for root filesystem>:<AFS Volume Server>[:<AFS Volume Server>]

For example, if you run an AFS cell called mycell.com with a root filesystem on the os.boot volume, and your volume servers are:
* 10.0.0.1
* 10.0.0.2
* 10.0.0.3

You could boot off it using:

    root:afs://mycell.com:os.boot:10.0.0.1:10.0.0.2:10.0.0.3
    
The syntax for the AFS volume follows the rules for manually adding a cell described in the AFS documentation in the kernel. (https://www.kernel.org/doc/html/latest/filesystems/afs.html).  The module simply adds the cell using the definition defined above to `/proc/fs/afs/cells`.  This module currently does NOT support DNS lookups for cells, although it is possible in a future revision of this module.

To use this module in an initrd, copy the contents of the `*.sh` into /usr/lib/dracut/modules.d/95afs/ on a system with a modern kernel with kafs built.  I've done all my testing in Fedora 34.  To make it load the dracut module when building the initrd, create a file in /etc/dracut.conf.d/ that has:

    add_dracutmodules+=" afs "

(the spaces around "afs" are important, dracut will complain if they aren't there and you can break the build process)

Then rebuild your initrd with `dracut -vf`.  Now your initrd should let you boot from AFS.

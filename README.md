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
    
The syntax for the AFS volume follows the rules for manually adding a cell described in the AFS documentation in the kernel. (https://www.kernel.org/doc/html/latest/filesystems/afs.html)

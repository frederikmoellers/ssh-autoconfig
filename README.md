# ssh-autoconfig
Dynamically generate `ssh_config` files on mobile devices.

`ssh-autoconfig` aims to help mobile users (i.e. with laptops) adapt their `ssh-config` files for different locations. You can specify *zones* with different config parts which will then be assembled into one large `ssh-config` file whenever the network settings change and these zones become active. See the source code for more info.

## INSTALLATION
First, modify the files `zones_user.py` and the files in `ssh_config_parts` to suit your needs. There are examples to help you write your own zones and config file parts. Remember that for `ssh_config`, directives can override each other. So, if you specify a `ProxyCommand` in a specialized zone file and use a default `ProxyCommand` in the common file, the default will only be used if the zone does not match the current network settings.

After adapting the files to your needs, simply execute `make install` as root and be happy. You can manually trigger `ssh-autoconfig` from the command line or wait until NetworkManager (or anything else) calls the installed hooks.

## UNINSTALLATION
Simply execute `make uninstall`.

## UPDATING
*Before* installing a new version, you might want to uninstall the old version *using the old Makefile and source checkout*. New Makefiles might include different script names or files and fail to clean up files from old installations. Note that you can always revert your repository to a previous commit, uninstall the old version using its Makefile and then install the new version.

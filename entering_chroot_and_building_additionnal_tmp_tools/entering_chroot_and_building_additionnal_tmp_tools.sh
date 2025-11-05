#!/bin/bash

DIRNAME="entering_chroot_and_building_additionnal_tmp_tools"

chmod ugo+x "$LFS/sources/$DIRNAME/preparechroot.sh"
chmod ugo+x "$LFS/sources/$DIRNAME/insidechroot.sh"
sudo "$LFS/sources/$DIRNAME/preparechroot.sh" "$LFS"

echo "ENTERING CHROOT ENVIRONMENT"
sleep 3

sudo chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    MAKEFLAGS="-j$(nproc)"      \
    TESTSUITEFLAGS="-j$(nproc)" \
    /bin/bash --login +h -c "/sources/$DIRNAME/insidechroot.sh"
#!/bin/bash

if source version-check.sh | grep "ERROR"; then
    echo "Version check failed, aborting."
    exit 1
fi 

if [ "$USER" == "root" ]; then
    echo "Do not run this script as root."
    exit 1
fi

export LFS=/mnt/lfs
export LFS_DISK=/dev/sda

set +h
umask 022

if [ ! -d "$LFS" ]; then
    mkdir -vp "$LFS"
fi

if ! grep -q "$LFS" /proc/mounts; then
    source setupdisk.sh "$LFS_DISK"
    sudo mount "${LFS_DISK}4" "$LFS"
    sudo chown lfs:lfs $LFS
    chmod 755 $LFS
fi

if [ ! -d "$LFS/sources" ]; then
    mkdir -v $LFS/sources
    chmod -v a+wt $LFS/sources
fi


cp -rf *.sh packages.csv \
    patches.csv \
    compiling_cross-toolchain \
    cross_compiling_tmp_tools \
    entering_chroot_and_building_additionnal_tmp_tools \
    "$LFS/sources"

source download.sh


mkdir -pv $LFS/{etc,var,tools} $LFS/usr/{bin,lib,sbin}


for i in bin lib sbin; do
    sudo ln -sv usr/$i $LFS/$i
done


case $(uname -m) in
    x86_64) mkdir -pv $LFS/lib64 ;;
esac

export LC_ALL=POSIX
export LFS_TGT=$(uname -m)-lfs-linux-gnu
export PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
export PATH=$LFS/tools/bin:$PATH
export CONFIG_SITE=$LFS/usr/share/config.site
export MAKEFLAGS=-j$(nproc)

# source compiling_cross-toolchain/compiling_cross-toolchain.sh
# source cross_compiling_tmp_tools/cross_compiling_tmp_tools.sh
source entering_chroot_and_building_additionnal_tmp_tools/entering_chroot_and_building_additionnal_tmp_tools.sh
# chmod ugo+x preparechroot.sh
# chmod ugo+x insidechroot.sh
# sudo ./preparechroot.sh "$LFS"

# echo "ENTERING CHROOT ENVIRONMENT"
# sleep 3


# sudo chroot "$LFS" /usr/bin/env -i   \
#     HOME=/root                  \
#     TERM="$TERM"                \
#     PS1='(lfs chroot) \u:\w\$ ' \
#     PATH=/usr/bin:/usr/sbin     \
#     MAKEFLAGS="-j$(nproc)"      \
#     TESTSUITEFLAGS="-j$(nproc)" \
#     /bin/bash --login +h -c "/sources/insidechroot.sh"
#!/bin/bash

if source version-check.sh | grep "ERROR"; then
    echo "Version check failed, aborting."
    exit 1
fi 

export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=/dev/sda

if [ ! -d "$LFS" ]; then
    sudo mkdir -vp "$LFS"
fi

if ! grep -q "$LFS" /proc/mounts; then
    source setupdisk.sh "$LFS_DISK"
    sudo mount "${LFS_DISK}4" "$LFS"
    sudo chown -v $USER "$LFS"
fi

mkdir -pv $LFS/sources
mkdir -pv $LFS/tools

mkdir -pv $LFS/boot
mkdir -pv $LFS/etc
mkdir -pv $LFS/bin
mkdir -pv $LFS/lib
mkdir -pv $LFS/sbin
mkdir -pv $LFS/usr
mkdir -pv $LFS/var

case $(uname -m) in
    x86_64) mkdir -pv $LFS/lib64 ;;
esac



cp -rf *.sh packages.csv patches.csv compiling_cross-toolchain cross_compiling_tmp_tools "$LFS/sources"
cd "$LFS/sources"
export PATH="$LFS/tools/bin:$PATH"


source download.sh
# source compiling_cross-toolchain/compiling_cross-toolchain.sh
source cross_compiling_tmp_tools/cross_compiling_tmp_tools.sh
#!/bin/bash

export LFS="$1"

if [ "$LFS" == "" ]; then
    echo "LFS is undefined!"
    exit 1
fi


chown --from lfs -R root:root $LFS/{usr,var,etc,tools}
case $(uname -m) in
x86_64) chown --from lfs -R root:root $LFS/lib64 ;;
esac

mkdir -pv $LFS/{dev,proc,sys,run}

# --- /dev ---
if ! mountpoint -q $LFS/dev; then
    mount -v --bind /dev $LFS/dev
else
    echo "$LFS/dev already mounted"
fi

# --- /dev/pts ---
if ! mountpoint -q $LFS/dev/pts; then
    mount -vt devpts devpts -o gid=5,mode=0620 $LFS/dev/pts
else
    echo "$LFS/dev/pts already mounted"
fi

# --- /proc ---
if ! mountpoint -q $LFS/proc; then
    mount -vt proc proc $LFS/proc
else
    echo "$LFS/proc already mounted"
fi

# --- /sys ---
if ! mountpoint -q $LFS/sys; then
    mount -vt sysfs sysfs $LFS/sys
else
    echo "$LFS/sys already mounted"
fi

# --- /run ---
if ! mountpoint -q $LFS/run; then
    mount -vt tmpfs tmpfs $LFS/run
else
    echo "$LFS/run already mounted"
fi

# --- /dev/shm ---
if [ -h $LFS/dev/shm ]; then
    install -v -d -m 1777 $LFS$(realpath /dev/shm)
elif ! mountpoint -q $LFS/dev/shm; then
    mount -vt tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
else
    echo "$LFS/dev/shm already mounted"
fi

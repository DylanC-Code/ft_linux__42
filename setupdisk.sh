#!/bin/bash

LFS_DISK="$1"

sudo fdisk "$LFS_DISK" << EOF
o
n
p
1

+1M
Y
n
p
2

+200M
Y
n
p
3

+2G
Y
n
p

+25G
Y
a
1
p
w
EOF

sudo mkfs.ext2 -L LFS_BOOT "${LFS_DISK}2" << EOF
y
EOF
sudo mkfs.ext4 -L LFS_ROOT "${LFS_DISK}4" << EOF
y
EOF
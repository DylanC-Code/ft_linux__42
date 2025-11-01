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
e

+25G
Y
a
1
p
w
EOF
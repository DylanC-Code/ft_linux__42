#!/bin/bash

PACKAGE_INSTALLER=$LFS/sources/packageinstall.sh
PACKAGES_DIRECTORY=cross_compiling_tmp_tools

echo "Cross compiling temporary tools"

for package in m4 ncurses bash coreutils diffutils file findutils gawk grep gzip make patch sed tar xz-utils binutils gcc; do
    source $PACKAGE_INSTALLER $PACKAGES_DIRECTORY $package
done


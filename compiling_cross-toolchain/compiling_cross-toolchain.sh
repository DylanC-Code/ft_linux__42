#!/bin/bash

PACKAGE_INSTALLER=$LFS/sources/packageinstall.sh
PACKAGES_DIRECTORY=compiling_cross-toolchain

echo "Compiling cross-toolchain"

cd $LFS/sources

for package in binutils gcc linux-api-headers glibc libstdc++; do
    source $PACKAGE_INSTALLER $PACKAGES_DIRECTORY $package
done
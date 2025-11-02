#!/bin/bash

PACKAGE_INSTALLER=$LFS/sources/packageinstall.sh
PACKAGES_DIRECTORY=compiling_cross-toolchain

echo "Compiling cross-toolchain"

source $PACKAGE_INSTALLER $PACKAGES_DIRECTORY binutils
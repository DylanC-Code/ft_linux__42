#!/bin/bash

PACKAGE_INSTALLER=/sources/packageinstall.sh
PACKAGES_DIRECTORY=entering_chroot_and_building_additionnal_tmp_tools

echo "Installing additional temporary tools inside chroot..."

if [ ! -f "$PACKAGE_INSTALLER" ]; then
    echo "Package installer '$PACKAGE_INSTALLER' is missing!"
    exit 1
fi

cd /sources


# for package in gettext bison perl python texinfo util-linux; do
#     source $PACKAGE_INSTALLER $PACKAGES_DIRECTORY $package
# done

source $PACKAGE_INSTALLER $PACKAGES_DIRECTORY gettext
#!/bin/sh
#
# This file is part of Hades, a minimal Windows VM for SolidWorks.
# Copyright (C) 2021 Ellie Clifford, Henry Franks
#
# Hades is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the
# Free Software Foundation, either version 3 of the License, or (at your
# option) any later version.
#
# Hades is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public
# License for more details.
#
# You should have received a copy of the GNU Affero General Public
# License along with Hades. If not, see <https://www.gnu.org/licenses/>.
#
# See https://wiki.archlinux.org/index.php/QEMU
# and https://serverfault.com/questions/727347/solidworks-activation-license-mode-is-not-supported-in-this-virtual-environment

# get directory of this file to use for other required files
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
HADES_DIR="$(realpath "$SCRIPT_DIR/..")"

# copy modifiable into run
if [ -d $HADES_DIR/run ]; then
	echo -ne "\\e[31m$HADES_DIR/run/ already exists, please "
	echo -e  "remove it before running this\\e[0m"
	exit 1
fi

echo -e '====> Copying OVMF vars...'
mkdir run; cd run
cp ../OVMF_* .

# Create image
echo -e '====> Creating main image...'
qemu-img create -f qcow2 hades.qcow2 64G

# Create dummy image for virtio
echo -e '====> Creating dummy image...'
qemu-img create -f qcow2 dummy.qcow2 1G

cd ..


echo -e '====> Starting Hades... please install Windows'
# Trying to comment in something like this is seriously funky, just accept it
/usr/bin/qemu-system-x86_64                                                   \
	                                                                          \
	-name hades,debug-threads=on                                              \
	                                                                          \
	`# Keep the resource usage sane so people don't have to edit it `         \
	-smp sockets=1,cores=4,threads=1                                          \
	-m 4G                                                                     \
	                                                                          \
	`# Enable KVM for better virtualization`                                  \
	-enable-kvm                                                               \
	                                                                          \
	`# These options are required for avoiding VM detection. In particular, ` \
	`# kvm=off disables the cpu virtualization leaf (not KVM!). `             \
	`# See 'qemu -cpu help' `                                                 \
	-cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,kvm=off,hv_vendor_id="whatever" \
	                                                                          \
	`# These are required for EFI`                                            \
	-drive if=pflash,format=raw,readonly,file=$HADES_DIR/run/OVMF_CODE.fd     \
	-drive if=pflash,format=qcow2,file=$HADES_DIR/run/OVMF_VARS.qcow2         \
	                                                                          \
	`# Don't use virtio for main disk until it is installed`                  \
	-drive file=$HADES_DIR/run/hades.qcow2,format=qcow2,if=ide,cache=none     \
	                                                                          \
	`# Load dummy for virtio driver to install`                               \
	-drive file=$HADES_DIR/run/dummy.qcow2,if=virtio                          \
	                                                                          \
	`# Virtio install disk`                                                   \
	-device ide-cd,bus=ide.1,drive=VirtioDVD                                  \
	-drive id=VirtioDVD,if=none,media=cdrom,file=$HADES_DIR/src/virtio-win.iso\
	                                                                          \
	`# Windows install media`                                                 \
	-device ide-cd,bus=ide.0,drive=WinDVD                                     \
	-drive id=WinDVD,if=none,media=cdrom,file=$HADES_DIR/src/Win10.iso        \

rcode=$?
if [ $rcode -ne 0 ]; then
	echo -ne '\e[31m====> Setup failed. Ensure that you have the source files '
	echo -n  'in the paths described in the installation instructions, and '
	echo     'check for general sanity.'
	echo -n  'If this error persists, please open an issue at '
	echo -e  'https://github.com/smh-my-head/hades\e[0m'
	exit $rcode
else
	echo -e '\e[32m====> Setup complete (if you did everything right)\e[0m'
fi

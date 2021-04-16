#!/bin/sh

# Minimal Windows VM for SolidWorks
# Copyright (C) 2021 Ellie Clifford, Henry Franks
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
# See https://wiki.archlinux.org/index.php/QEMU
# and https://serverfault.com/questions/727347/solidworks-activation-license-mode-is-not-supported-in-this-virtual-environment

# copy modifiable into run
if [ -d run ]; then
	echo "run/ already exists, please remove it before running this"
	exit 1
fi

mkdir run; cd run
cp ../OVMF_* .

# Create image
qemu-img create -f qcow2 hades.qcow2 64G

# Create dummy image for virtio
qemu-img create -f qcow2 dummy.qcow2 1G

cd ..

# get directory of this file to use for other required files
SCRIPT_DIR=$(dirname "$0")

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
	-drive if=pflash,format=raw,readonly,file=$SCRIPT_DIR/run/OVMF_CODE.fd    \
	-drive if=pflash,format=qcow2,file=$SCRIPT_DIR/run/OVMF_VARS.qcow2        \
	                                                                          \
	`# Don't use virtio for main disk until it is installed`                  \
	-drive file=$SCRIPT_DIR/run/hades.qcow2,format=qcow2,if=ide,cache=none    \
	                                                                          \
	`# Load dummy for virtio driver to install`                               \
	-drive file=$SCRIPT_DIR/run/dummy.qcow2,if=virtio                         \
	                                                                          \
	`# Virtio install disk`                                                   \
	-device ide-cd,bus=ide.1,drive=VirtioDVD                                  \
	-drive id=VirtioDVD,if=none,media=cdrom,file=$SCRIPT_DIR/src/virtio-win.iso \
	                                                                          \
	`# Windows install media`                                                 \
	-device ide-cd,bus=ide.0,drive=WinDVD                                     \
	-drive id=WinDVD,if=none,media=cdrom,file=$SCRIPT_DIR/src/Win10.iso       \

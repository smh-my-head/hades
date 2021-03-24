#!/bin/sh

# Minimal Windows VM for SolidWorks
# Copyright (C) 2021 Tim Clifford, Henry Franks
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

# See https://wiki.archlinux.org/index.php/QEMU
# and https://serverfault.com/questions/727347/solidworks-activation-license-mode-is-not-supported-in-this-virtual-environment

# get directory of this file to use for other required files
SCRIPT_DIR=$(dirname "$0")

# Trying to comment in something like this is seriously funky, just accept it

/usr/bin/qemu-system-x86_64                                                   \
	                                                                          \
	-name sw-minimal,debug-threads=on                                         \
	                                                                          \
	`# You may want to change the next two options, `                         \
	`# they relate to resource allocation`                                    \
	-smp sockets=1,cores=8,threads=1                                          \
	-m 8G                                                                     \
	                                                                          \
	`# Enable KVM for better virtualization`                                  \
	-enable-kvm                                                               \
	                                                                          \
	`# These options are required for avoiding VM detection. In particular, ` \
	`# kvm=off disables the cpu virtualization leaf (not KVM!). `             \
	`# See 'qemu -cpu help' `                                                 \
	-cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,kvm=off,hv_vendor_id="whatever" \
	                                                                          \
	`# If you change the image name, that's sw-minimal.qcow2 here. virtio is `\
	`# required to avoid detection (and it's faster!)`                        \
	-drive file=$SCRIPT_DIR/sw-minimal.qcow2,format=qcow2,if=virtio,cache=none\
	                                                                          \
	`# These are required for EFI`                                            \
	-drive if=pflash,format=raw,readonly,file=$SCRIPT_DIR/OVMF_CODE.fd        \
	-drive if=pflash,format=qcow2,file=$SCRIPT_DIR/OVMF_VARS.qcow2            \
	                                                                          \
	`# Add root directory of host as network drive at \\10.0.2.4\qemu`        \
	-net nic                                                                  \
	-net user,smb=$HOME                                                       \
	                                                                          \
	`# Start a vm monitor to communicate over`                                \
	-monitor unix:/tmp/vm_monitor.socket,server,nowait                        \
	                                                                          \
	`# Spice`                                                                 \
	-vga qxl                                                                  \
	-device virtio-serial-pci                                                 \
	`# You may want to change this unix socket to a network socket, `         \
	`# see the ArchWiki link at the top`                                      \
	-spice unix,addr=/tmp/vm_spice.socket,disable-ticketing                   \
	-device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0      \
	-chardev spicevmc,id=spicechannel0,name=vdagent                           \
	`# Automatically open a spice viewer. Alternatively you can connect to`   \
	`# the socket manually after startup`                                     \
	-display spice-app                                                        \
	                                                                          \
	`# Include any other command line options`                                \
	$@

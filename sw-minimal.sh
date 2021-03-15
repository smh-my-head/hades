#!/bin/sh

# See https://wiki.archlinux.org/index.php/QEMU
# and https://serverfault.com/questions/727347/solidworks-activation-license-mode-is-not-supported-in-this-virtual-environment

# Trying to comment in something like this is seriously funky, just accept it

sudo /usr/bin/qemu-system-x86_64                                              \
	                                                                          \
	-name sw-minimal,debug-threads=on                                         \
	                                                                          \
	`# You may want to change the next two options, `                         \
	`# they relate to resource allocation`                                    \
	-smp sockets=1,cores=8,threads=1                                          \
	-m 8G                                                                     \
	                                                                          \
	`# Enable KVM for better virtualization`    	    	    	    	  \
	-enable-kvm                                                               \
	-net nic                                                                  \
	-net user,smb=/                                                           \
	                                                                          \
	`# These options are required for avoiding VM detection. In particular, ` \
	`# kvm=off disables the cpu virtualization leaf (not KVM!). `             \
	`# See 'qemu -cpu help' `                                                 \
	-cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,kvm=off,hv_vendor_id="whatever" \
	                                                                          \
	`# If you change the image name, that's sw-minimal.qcow2 here. virtio is `\
	`# required to avoid detection (and it's faster!)`                        \
	-drive file=sw-minimal.qcow2,format=qcow2,if=virtio,cache=none            \
	                                                                          \
	`# These are required for EFI`                                            \
	-drive if=pflash,format=raw,readonly,file=OVMF_CODE.fd                    \
	-drive if=pflash,format=raw,file=OVMF_VARS.fd                             \
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

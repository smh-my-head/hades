#!/bin/sh

# See https://wiki.archlinux.org/index.php/QEMU
# and https://serverfault.com/questions/727347/solidworks-activation-license-mode-is-not-supported-in-this-virtual-environment

# Trying to comment in something like this is seriously funky, just accept it
sudo /usr/bin/qemu-system-x86_64                                              \
	                                                                          \
	-name sw-minimal,debug-threads=on                                         \
	                                                                          \
	`# Keep the resource usage sane so people don't have to edit it `         \
	-smp sockets=1,cores=4,threads=1                                          \
	-m 4G                                                                     \
	                                                                          \
	`# Enable KVM for better virtualization`    	    	    	    	  \
	-enable-kvm                                                               \
	                                                                          \
	`# These options are required for avoiding VM detection. In particular, ` \
	`# kvm=off disables the cpu virtualization leaf (not KVM!). `             \
	`# See 'qemu -cpu help' `                                                 \
	-cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,kvm=off,hv_vendor_id="whatever" \
	                                                                          \
	`# These are required for EFI`                                            \
	-drive if=pflash,format=raw,readonly,file=OVMF_CODE.fd                    \
	-drive if=pflash,format=raw,file=OVMF_VARS.fd                             \
	                                                                          \
	`# Don't use virtio for main disk until it is installed`                  \
	-drive file=sw-minimal.qcow2,format=qcow2,if=ide,cache=none               \
	                                                                          \
	`# Load dummy for virtio driver to install`                               \
	-drive file=dummy.qcow2,if=virtio                                         \
	                                                                          \
	`# Load Windows install disk`                                             \
	-cdrom Win10_20H2_v2_English_x64.iso                                      \
	                                                                          \
	`# Virtio install disk`                                                   \
	-device ide-cd,bus=ide.1,drive=VirtioDVD                                  \
	-drive id=VirtioDVD,if=none,media=cdrom,file=./'virtio-win-0.1.185.iso'   \
	                                                                          \
	`# Windows install media`                                                 \
	-device ide-cd,bus=ide.0,drive=WinDVD                                     \
	-drive id=WinDVD,if=none,media=cdrom,file=./'Win10_20H2_v2_English_x64.iso' \

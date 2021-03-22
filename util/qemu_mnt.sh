sudo modprobe nbd max_part=8
sudo qemu-nbd -n --connect=/dev/nbd0 sw-minimal.qcow2


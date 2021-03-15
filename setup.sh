#!/bin/sh

# Create image
qemu-img create -f qcow2 sw-minimal.qcow2 64G

# Create dummy image for virtio
qemu-img create -f qcow2 dummy.qcow2 1G

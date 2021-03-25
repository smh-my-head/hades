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

# copy modifiable into run
if [ -d run ]; then
	echo "run/ already exists, please remove it before running this"
fi

mkdir run; cd run
cp ../OVMF_* run
ln -s ../start-vm.sh

# Create image
qemu-img create -f qcow2 sw-minimal.qcow2 64G

# Create dummy image for virtio
qemu-img create -f qcow2 dummy.qcow2 1G



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

usage() {
	cat << EOF
Usage: $0 [OPTION]... FILE
Sets up Hades with the provided image FILE, decompressing it first.

  -h, --help            display this help and exit
  -m, --move            don't decompress FILE, just move it into place

EOF
}

move=false
for i in $@; do
	case $i in
		-h|--help )
			usage
			exit 0
			;;
		-m|--move )
			move=true
			if ! shift; then # $2 -> $1, $# is decreased, etc
				usage
				exit 1
			fi
			;;
		*)
			break
			;;
	esac
done

if [ $# -ne 1 ]; then
	usage
	exit 1
fi

if echo "$1" | egrep -vq '\.qcow2$'; then
	echo "$1 does not seem to be a valid qcow2 image"
	exit 1
fi

# get directory of hades to use for other required files
HADES_DIR=$(dirname $(dirname $(realpath "$0")))

# copy modifiable into run
if [ -d $HADES_DIR/run ]; then
	echo "$HADES_DIR/run/ already exists, please remove it before running this"
	exit 1
fi

mkdir $HADES_DIR/run
cp $HADES_DIR/OVMF_* $HADES_DIR/run/

if [ "$move" = "true" ]; then
	mv $1 $HADES_DIR/run/hades.qcow2
else
	echo "====> Decompressing provided image, please wait"
	qemu-img convert -O qcow2 $1 $HADES_DIR/run/hades.qcow2
fi


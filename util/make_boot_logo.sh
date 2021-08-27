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

# This is not copyrightable lmfao -- TC

# get directory of this file to use for other required files
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
HADES_DIR="$(realpath "$SCRIPT_DIR/..")"

cd $HADES_DIR/img
convert logo.svg -background black -depth 8 -resize 200 \
	-compress none -type palette BMP3:Logo.bmp
cd - >/dev/null

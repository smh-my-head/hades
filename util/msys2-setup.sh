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

# get directory of this file to use for other required files
SCRIPT_DIR=$(dirname "$0")

# install packages
pacman -S man-db man-pages-posix git openssh cygrunsrv \
          mingw-w64-x86_64-editrights

# setup sshd
$SCRIPT_DIR/msys2-sshd-setup.sh

# fix terminals
mkdir -p .ssh
echo "TERM=xterm" > ~/.ssh/environment
sed -i 's/.*\(PermitUserEnvironment\).*/\1 yes/' /etc/ssh/sshd_config

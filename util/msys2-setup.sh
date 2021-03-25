#!/bin/sh

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

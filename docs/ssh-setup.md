# SSH from the host to the guest

1. Install msys2 on the guest. You can get the installer
   [here](https://www.msys2.org/)
2. Inside admin msys2, run `//10.0.2.4/qemu/path/to/util/msys2-setup.sh`
3. Open port 22 on the guest
4. From the host, run `ssh -p 6969 windows-username@localhost`. The user must
   have a password for this to work. You can use `passwd` to create one easily



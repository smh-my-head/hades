# SSH from the host to the guest

1. Install msys2 on the guest. You can get the installer
   [here](https://www.msys2.org/)
2. Inside admin msys2, run `//10.0.2.4/qemu/path/to/util/msys2-setup.sh`
3. Open port 22 on the guest
4. From the host, run `ssh -p 2200 windows-username@localhost`. The user must
   have a password for this to work. You can use `passwd` to create one easily
5. Lots of things can go wrong. See
   [here](https://gist.github.com/samhocevar/00eec26d9e9988d080ac) for common
   problems etc. It is possible to use ssh keys, but you will have to generate
   /etc/passwd and possibly /etc/group with `mkpasswd -l > /etc/passwd &&
   mkgroup -l > /etc/group`

This file is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].
See [DOC_LICENSE](../DOC_LICENSE).

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png

# Procedure to clean and minify Windows VMs

### From Guest

1. Defragment
2. Shrink partition (note down final size!)
3. Zero all remaining free space with `sdelete -z c:`, this will make
   compression more efficient (get `sdelete`
   [here](https://docs.microsoft.com/en-us/sysinternals/downloads/sdelete))

### From Host

1. Shrink vm image with `qemu-img resize --shrink img.qcow2 SIZE` (see `man
   qemu-img` for SIZE)

2. Sparsify and compress vm image with
   `qemu-img convert -c -O qcow2 img.qcow2 img-compressed.qcow2` (the -c flag
   will compress it, but make disk speeds slower, you can leave the flag out,
   or undo this with `qemu-img convert -O qcow2 img-compressed.qcow2 img.qcow2`

This file is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].
See [DOC_LICENSE](../DOC_LICENSE).

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png

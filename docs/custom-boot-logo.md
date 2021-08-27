# Enable the CUSF boot logo

1. Generate the right type of bitmap with `./util/make_boot_logo.sh`. The
   result will be at `./img/Logo.bmp`.
2. Compile [EDK2](https://github.com/tianocore/edk2), replacing
   `edk2/MdeModulePkg/Logo/Logo.bmp` with `./img/Logo.bmp`.
3. Convert `./OVMF_VARS.fd` (the compilation output) to qcow2 format with
   `qemu-img convert -0 qcow2 OVMF_VARS.fd OVMF_VARS.qcow2`
4. Replace `./OVMF_VARS.qcow2` with the new file you have just created
5. ???
6. Profit

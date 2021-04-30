# Start SolidWorks faster

**To set up:**

1. Install `openbsd-netcat` (the name may vary, this is correct on Arch Linux)
2. Start Hades and open SolidWorks
3. On the host, open the qemu monitor with `hades-monitor`
4. Enter `savevm solidworks` in the qemu monitor. This will save a snapshot
   with the name `solidworks`
5. Run `sudo make solidworks` to install `solidworks` to your `PATH`

**To use:**

Start SolidWorks with `solidworks` and wait for the virtual machine to boot
(there will be no feedback except something like "Connecting to graphic server"
until it has booted). This usually takes 10-15 seconds, but can vary depending
on a few factors.

This file is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].
See [DOC_LICENSE](../DOC_LICENSE).

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png

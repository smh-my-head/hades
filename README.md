# Minimal Windows VM for SolidWorks

Documentation: [![CC BY-SA 4.0][cc-by-sa-shield]][cc-by-sa]

Code:          [![CC BY-SA 4.0][gplv3-shield]][gplv3]

Tested on Windows 10 20H2 v2 with SolidWorks 2018 SP3

Note: If you know me or @henryefranks personally and have licenses for all of
this software, drop one of us a message and we can pass on either a minimal
working image (9.9GB), or all the proprietary files necessary (20GB). Then have
a look at [docs/fast-start.md](docs/fast-start.md) to set yourself up for
starting SolidWorks quickly.

## Prerequisites

#### On the host (Linux)

Note: The ISOs should be placed in this directory.

- QEMU (should be available in your package manager)
- a SPICE viewer (e.g. virt-viewer).
- [Windows
   ISO](https://www.microsoft.com/en-gb/software-download/windows10ISO),
- [Virtio ISO](https://github.com/virtio-win/virtio-win-pkg-scripts)

#### On the guest (Windows)

- SPICE guest tools binary. Can be found
  [here](https://www.spice-space.org/download.html) (navigate to
  *Guest->Windows Binaries*)

- SolidWorks installer (this can be downloaded on Linux, the Linux filesystem
  will be mapped as a network drive later on)

## Setup

1. Create a new VM image with `./setup.sh`. This will also create a dummy image
   which will be needed later.

2. Install Windows on the VM with `./first-run.sh`. You may need to edit
   `./first-run.sh` to point to your ISOs, it should be obvious how to do this
   when you look at the file. It may take a while to boot for the first time,
   don't panic! If you get stuck in the VM, know that Ctrl-Alt-G releases
   the mouse.

3. Within Windows, install the virtio drivers by following these instructions
   from the ArchWiki (using to the dummy disk created in step 1)

> Windows will detect the fake disk and look for a suitable driver. If it
> fails, go to Device Manager, locate the SCSI drive with an exclamation mark
> icon (should be open), click Update driver and select the virtual CD-ROM. Do
> not navigate to the driver folder within the CD-ROM, simply select the CD-ROM
> drive and Windows will find the appropriate driver automatically (tested for
> Windows 7 SP1).

4. Within Windows, install the SPICE guest tools
   [here](https://www.spice-space.org/download.html) (navigate to
   *Guest->Windows Binaries*)

5. Shutdown the VM and delete the dummy image `dummy.qcow2`

6. Start the VM again with `./start-vm.sh`. This is how you
   can start the VM from now on. You may want to edit `start-vm.sh` to change
   the core count and memory allocation, along with any other tweaks.

7. Within Windows, connect to a the host filesystem with a loopback network
   device, by navigating in the file explorer to *This PC -> Computer -> Map
   network drive* and entering `\\10.0.2.4\qemu` under *Folder:*

8. Install SolidWorks as usual. (If you downloaded it on Linux, you can install
   directly from the network drive)

9. Optionally follow the instructions in
   [docs/fast-start.md](docs/fast-start.md) to set yourself up for starting
   SolidWorks quickly.

## Suggestions

See [this list](docs/suggested-tweaks.md) of suggested tweaks for using Windows
in a VM, and [this procedure](docs/minify.md) to shrink and compress your
image.

- See [this ArchWiki page](https://wiki.archlinux.org/index.php/QEMU) for
  advanced options, and [this ArchWiki
  page](https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF) to
  configure PCI passthrough and other performance tweaks.

## A Note on SolidWorks Network Licences

Using this without a SolidWorks Network License contravenes the SolidWorks
licensing. However, this procedure *does* successfully convince SolidWorks
that it's not in a VM. This is justifiable because there are artificial locks
against using "unsupported" hypervisors, so you couldn't do it without
tricking SolidWorks even with the correct license.

## License

The files [OVMF_CODE.fd](OVMF_CODE.fd) and [OVMF_VARS.qcow2](OVMF_VARS.qcow2)
are licensed according to [EDK2_LICENSE](EDK2_LICENSE).

This file is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].
See [DOC_LICENSE](DOC_LICENSE).

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png
[cc-by-sa-shield]: https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg

[gplv3]: https://www.gnu.org/licenses/gpl-3.0.html
[gplv3-shield]: https://img.shields.io/badge/License-GPL%20(>%3D%203)-lightgrey.svg

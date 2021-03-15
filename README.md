# Windows VM for SolidWorks

Tested on Windows 10 20H2 v2 with SolidWorks 2018 SP3

Note: If you know me personally and have licenses for all of this software,
drop me a message and I can give you either a minimal working image, or all the
files necessary.

## Prerequisites

#### On the host (Linux)

The ISOs and OVMF firmware should be placed in this directory.

- QEMU (should be available in your package manager)
- a SPICE viewer (e.g. virt-viewer).
- [Windows
   ISO](https://www.microsoft.com/en-gb/software-download/windows10ISO),
- [Virtio ISO](https://github.com/virtio-win/virtio-win-pkg-scripts)
- OVMF firmware. (files `OVMF_CODE.fd` and `OVMF_VARS.fd`). You can get this
  from the `edk2-ovmf` package on Arch Linux (might be called something else on
  other distributions)

#### On the guest (Windows)

- SPICE guest tools binary. Can be found
  [here](https://www.spice-space.org/download.html) (navigate to
  *Guest->Windows Binaries*)

- SolidWorks installer (this can be downloaded on Linux, we can map the Linux
  filesystem as a network drive later on)

## Setup

1. Create a new VM image with `./setup.sh`. This will also create a dummy image
   which will be needed later.

2. Install Windows on the VM with `./first-run.sh`. You may need to edit
   `./first-run.sh` to point to your ISOs, it should be obvious how to do this
   when you look at the file. It may take a while to boot for the first time,
   don't panic! If you get stuck in the VM, remember that Ctrl-Alt-G releases
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

6. Start the VM again with `./sw-minimal.sh`. This is how you
   can start the VM from now on. You may want to edit `sw-minimal.sh` to change
   the core count and memory allocation, along with any other tweaks.

7. Within Windows, connect to a the host filesystem with a loopback network
   device, by navigating in the file explorer to *This PC -> Computer -> Map
   network drive* and entering `\\10.0.2.4\qemu` under *Folder:*

8. Install SolidWorks as usual. (If you downloaded it on Linux, you can install
   directly from the network drive)

## Suggestions

See [this list](docs/suggested-tweaks.md) of suggested tweaks for using Windows
in a VM, and [this procedure](docs/minify.md) to shrink and compress your
image.

## Notes

- Using this without a SolidWorks Network License contravenes the SolidWorks
  licensing. However, this script *does* successfully convince SolidWorks that
  it's not in a VM, because there are artificial locks against using
  "unsupported" hypervisors, so you couldn't do it without tricking SolidWorks
  even with the correct license.

- See [this ArchWiki page](https://wiki.archlinux.org/index.php/QEMU) for
  advanced options, and [this ArchWiki
  page](https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF) to
  configure PCI passthrough and other performance tweaks.

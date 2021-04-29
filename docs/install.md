# Install Hades from scratch

## Prerequisites

**On the host (Linux)**

- [Hades](https://github.com/smh-my-head/hades)
- QEMU (should be available in your package manager)
- a SPICE viewer (e.g. virt-viewer).
- [Windows
   ISO](https://www.microsoft.com/en-gb/software-download/windows10ISO),
- [Virtio ISO](https://github.com/virtio-win/virtio-win-pkg-scripts)

**On the guest (Windows)**

- SPICE guest tools binary. Can be found
  [here](https://www.spice-space.org/download.html) (navigate to
  *Guest->Windows Binaries*)

- SolidWorks installer (this can be downloaded on Linux, the Linux filesystem
  will be mapped as a network drive later on)

## Setup

1. First, grab the necessary ISOs and place theme at `./src/Win10.iso` and
   `./src/virtio-win.iso`

2. Run `./setup.sh`. This will create a new VM image and begin the Windows
   installation, putting all the modifiable files in `run` (to keep the git
   working tree clean). It may take a while to boot for the first time, don't
   panic! If you get stuck in the VM, know that Ctrl-Alt-G releases the mouse.

3. Within Windows, install the virtio drivers by following these instructions
   from the ArchWiki

> Windows will detect the fake disk and look for a suitable driver. If it
> fails, go to Device Manager, locate the SCSI drive with an exclamation mark
> icon (should be open), click Update driver and select the virtual CD-ROM. Do
> not navigate to the driver folder within the CD-ROM, simply select the CD-ROM
> drive and Windows will find the appropriate driver automatically (tested for
> Windows 7 SP1).

4. Within Windows, install the SPICE guest tools
   [here](https://www.spice-space.org/download.html) (navigate to
   *Guest->Windows Binaries*)

5. Shutdown the VM and delete the dummy image `run/dummy.qcow2`, which was
   used to set up virtio and is no longer needed

6. Start the VM again with `hades.sh`. This is how you
   can start the VM from now on. You may want to edit `hades.sh` to change
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

See the rest of the docs for ways to make the vm even better (including
minifying, skipping some of the boot process, and other tweaks)

- See [this ArchWiki page](https://wiki.archlinux.org/index.php/QEMU) for
  advanced options, and [this ArchWiki
  page](https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF) to
  configure PCI passthrough and other performance tweaks.

This file is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].
See [DOC_LICENSE](../DOC_LICENSE).

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png

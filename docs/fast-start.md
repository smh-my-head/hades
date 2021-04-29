# Start SolidWorks faster

## Setup

1. Start the vm and open SolidWorks
2. On the host, open the qemu monitor with `util/qemu_monitor.sh`
3. Enter `savevm solidworks` in the qemu monitor. This will save a snapshot
with the name `solidworks`

## Usage

- Start the vm with `./hades.sh -loadvm solidworks`

This file is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].
See [DOC_LICENSE](../DOC_LICENSE).

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png

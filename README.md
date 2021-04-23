# Hades

Hell itself (aka a minimal Windows vm). Designed for use with
[Charon](https://github.com/smh-my-head/charon)

Documentation: [![CC BY-SA 4.0][cc-by-sa-shield]][cc-by-sa]

Code:          [![CC BY-SA 4.0][gplv3-shield]][gplv3]

Tested on Windows 10 20H2 v2 with SolidWorks 2018 SP3

## Installation

If you know any of the contributors personally and have licenses for all of the
required proprietary software, drop one of us a message and we can pass on
working image (9.9GB, all credit to @henryefranks).

Otherwise, have a look at [docs/install.md](docs/install.md) to set up the VM
from scratch. If you are some sort of masochist and want to do it from scratch
despite knowing the contributors, we can send you all the proprietary files
necessary (20GB).

## Tweaks

You may like to have a look through the other files in [docs/](docs/), which
contain tweaks and features you may want to use. These are all implemented in
the minimal image we can provide. Note that [docs/ssh.md](docs/ssh.md) is
required for [Charon](https://github.com/smh-my-head/charon)

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

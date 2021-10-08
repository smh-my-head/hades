# Hades

Hell itself (aka a minimal Windows virtual machine). Designed for use with
[Charon](https://github.com/smh-my-head/charon)

Documentation: [![CC BY-SA 4.0][cc-by-sa-shield]][cc-by-sa]

Code:          [![CC BY-SA 4.0][gplv3-shield]][gplv3]

Tested on Windows 10 20H2 v2 with SolidWorks 2018 SP3 (Revision 1) and Windows
10 21H1 with Solidworks 2020 SP3 (Revision 2)

## Installation

Clone this repository and then follow the instructions on the [CUSF
Wiki](https://wiki.cusf.co.uk/Hades)

## Contributing

Anyone is welcome to contribute. In particular, if you encounter any problems
or have suggestions of further tweaks, please open an issue or pull request.

## A Note on SolidWorks Network Licences

Using this without a SolidWorks Network License contravenes the SolidWorks
licensing. However, this procedure *does* successfully convince SolidWorks
that it's not in a VM. This is justifiable because there are artificial locks
against using "unsupported" hypervisors, so you couldn't do it without
tricking SolidWorks even with the correct license. Please don't sue us.

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

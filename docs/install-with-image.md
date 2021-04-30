# Install Hades with our image

First install QEMU, a SPICE viewer, and samba. For example on Arch Linux, that
would look something like this:

```bash
sudo pacman -S qemu virt-viewer samba
```

Download the image [https://files.cusf.co.uk/hades-rev1.qcow2 here]. If you get
a permission error, you will need to message [[User:EllieClifford|Ellie]] or
[[User:HenryFranks|Henry]] to get access.

Then, clone the Hades repository and set up the required files:

```bash
git clone https://github.com/smh-my-head/hades
mkdir hades/run
cp hades/OVMF_* hades/run
qemu-img convert -O qcow2 /path/to/hades-rev1.qcow2 hades/run/hades.qcow2
```

Then just run `./hades/hades.sh` to start Hades. The password is
<code>a</code>. You may also want to see
[docs/fast-start.md](docs/fast-start.md) to make starting SolidWorks quicker
(note that this will decrease portability)

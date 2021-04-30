# Install Hades with our image

First install QEMU, a SPICE viewer, and samba. As an example, on Arch Linux,
that would look something like this:

```bash
sudo pacman -S qemu virt-viewer samba
```

Download the image [https://files.cusf.co.uk/hades-rev1.qcow2 here]. If you get
a permission error, you will need to message [[User:EllieClifford|Ellie]] or
[[User:HenryFranks|Henry]] to get access.

Then, clone the Hades repository and install it with the image:

```bash
git clone https://github.com/smh-my-head/hades
cd hades
make with-image image=path/to/hades-rev1.qcow2
sudo make install
```

Then just run `hades` from a terminal (or in the normal way you would run
programs) to start Hades. The password is <code>a</code>. You may also want to
see [docs/fast-start.md](docs/fast-start.md) to make starting SolidWorks
quicker (note that this will decrease portability)

# Install Hades with our image

1. Install QEMU, a SPICE viewer, and samba. As an example, on Arch Linux,
that would look something like this:

```bash
sudo pacman -S qemu virt-viewer samba
```

2. Download the image [here](https://files.cusf.co.uk/hades-rev1.qcow2). If you
get a permission error, you will need to message [[User:EllieClifford|Ellie]] or
[[User:HenryFranks|Henry]] to get access.

3. (Optionally) verify the integrity and signature of the files by downloading
[the checksum](https://files.cusf.co.uk/hades-rev1.qcow2.sha256) and
[the signature](https://files.cusf.co.uk/hades-rev1.qcow2.asc) and verifying
them:

```bash
gpg --import <(curl -L pgp.cusf.co.uk/ellie-clifford.asc) # Import Ellie's public key
gpg --verify hades-rev1.qcow2.asc hades-rev1.qcow2 # Verify that Ellie signed the image
sha256sum -c hades-rev1.qcow2.sha256 # Verify the integrity of the image
```

4. Clone the Hades repository and install Hades with the image:

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

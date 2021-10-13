# Install Hades with our image

The latest image (Revision 2) is built with:

- Solidworks 2020 SP03

- Windows 10 21H1 English International

- Virtio 0.1.208

{{Warning|This image is accessible over SSH from the host, with a publicly
available key used by [[Charon]]. The key can also be found in `keys/`. Make
sure that this is not accessible to anyone else on the network by making sure
that the output of `nmap $(hostname -i)` does not show port 2200 as
open.}}

1. Install QEMU, a SPICE viewer, and samba. As an example, on Arch Linux,
that would look something like this:

```bash
sudo pacman -S qemu virt-viewer samba
```

2. Download the image [here](https://files.cusf.co.uk/hades-v2/hades-v2.qcow2).
The file is currently accessible to Cambridge students only.

3. (Optionally) verify the integrity and signature of the files by downloading
[the checksum](https://files.cusf.co.uk/hades-v2/hades-v2.qcow2.sha256) and
[the signature](https://files.cusf.co.uk/hades-v2/hades-v2.qcow2.asc) and
verifying them:

```bash
gpg --import <(curl -L pgp.cusf.co.uk/ellie-clifford.asc) # Import Ellie's public key
gpg --verify hades-v2.qcow2.asc hades-v2.qcow2 # Verify that Ellie signed the image
sha256sum -c hades-v2.qcow2.sha256 # Verify the integrity of the image
```

4. Clone the Hades repository and install Hades with the image:

```bash
git clone https://github.com/smh-my-head/hades
cd hades
make with-image image=path/to/hades-v2.qcow2
sudo make install
```

Then just run `hades` from a terminal (or in the normal way you would run
programs) to start Hades. You may also want to see
[docs/fast-start.md](docs/fast-start.md) to make starting SolidWorks quicker
(note that this will decrease portability)

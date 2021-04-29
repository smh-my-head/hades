# Install Hades with our image

First, clone the Hades repository and set up some required files:

```bash
git clone https://github.com/smh-my-head/hades
mkdir hades/run
cp hades/OVMF_* hades/run
```

Email [[User:EllieClifford|Ellie]] or [[User:HenryFranks|Henry]] to get the image,
and place it at `hades/run/hades.qcow2`

Then just run `./hades/hades.sh` to start Hades. You may also want to see
[docs/fast-start.md](docs/fast-start.md) to make starting SolidWorks quicker
(beware that this will decrease portability)

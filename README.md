# pseudo-design-linux-dev

Development workspace container for Pseudo Design Linux distros created with the Yocto project.

This repository is not intended to be interacted with directly!  See the [manifest repository](https://github.com/PseudoDesign/pseudo-design-linux-manifest) for details on setting up this environment using `repo`.

## Install Required Software

* Must be run on Linux or in WSL using a non-NFTS formatted drive.
* Install Docker on your system
* Install [repo](https://gerrit.googlesource.com/git-repo): `sudo apt update && sudo apt install repo`

## Quick Start - Build and Install on Cora Z7s

* Install the required software as described above
* Create an empty directory, `cd` to that directory
* Set up the `scarthgap` branch of the project: `repo init -u git@github.com:PseudoDesign/pseudo-design-linux-manifest.git -b scarthgap -m xilinx.xml`
* Sync the repositories with `repo sync`
* Build and start the development docker container: `./create-build-image.sh && ./start-build-image.sh`
  * Source the environment wtih `source setupsdk`
  * Build the image with `MACHINE=cora-z7 bitbake petalinux-image-minimal`
* Program the `.wic` file to the SD card
* Set the board to boot from SD card by shorting JP2
* Open the terminal with `sudo picocom /dev/ttyUSB1 -b 115200` (your device may vary)

### Run QEMU for ZCU102

`MACHINE=cora-z7 bitbake core-image-minimal`
`runqemu zcu102-zynqmp nographic`
# pseudo-design-linux-dev

Development workspace container for Pseudo Design Linux distros created with the Yocto project.

This repository is not intended to be interacted with directly!  See the [manifest repository](https://github.com/PseudoDesign/pseudo-design-linux-manifest) for details on setting up this environment using `repo`.

See https://source.android.com/docs/setup/reference/repo for details on how to interact with the various git repositories in the project.

## Quick Start - Run ZCU102 in QEMU

* Choose your yocto release, e.g. `repo init -b gatesgarth`
* Choose your manifest, e.g. `repo init -m xilinx.xml`
* Sync the repositories with `repo sync`
* Build and start the development docker container: `./create-build-image.sh && ./start-build-image.sh`
  * Source the environment with `source setupsdk`
  * Build the image with `MACHINE=hello-world-zcu102-zynqmp bitbake petalinux-image-minimal`
  * Start QEMU with `runqemu hello-world-zcu102-zynqmp`
  * When finished, stop QEMU with `CTRL-A`, `X`

## Features

* Note the partition table is set up for OTA firmware updates.
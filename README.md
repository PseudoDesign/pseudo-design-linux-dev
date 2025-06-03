# pseudo-design-linux-dev

Contains the development environment for pd-linux.

Don't clone this repository directly.  Instead use [repo](https://gerrit.googlesource.com/git-repo).  Run the following in an empty directory to get started:

`repo init -u git@github.com:PseudoDesign/pseudo-design-linux-manifest.git -b scarthgap`

`repo sync`

## Introduction to Yocto (Work in Progress)

If you're new to Yocto, check out the [Intro to Yocto](docs/intro.md) document. This describes the motivations, defines terms, and lays out the structure of this project.

### Quick Start

#### Cora Z7 

This describes the steps needed to set up and build images to run on the Cora Z7.  Details on these commands can be found elsewhere in the documentation.

* Bring up a shell in the development container: `rake docker:start`
* Set up the development environment: `source setupsdk workspace/scarthgap/xilinx`
* Add the `meta-pseudo-design` configuration: `bitbake-layers add-layer ../../../sources/meta-pseudo-design/`
* Compile the minimal cora-z7 image: `MACHINE=cora-z7 bitbake petalinux-image-minimal`
# Intro to Yocto

## What is Yocto

### Side Note: What is Petalinux?

## Why use Yocto

### Supported by your HW manufacturer

### Gives you everything you need (even the stuff you don't know yet!)

* Provides SDK
* Provides software BOM
* Can provide QEMU targets
* Many release artificats (WIC, Mender upgrade, etc)

### Portable, Iteratable, Maintainable

* One project that supports multiple boards (EVK5, ZCU102, RPI, etc)
* One project that supports multiple images (development, production, vendor-specific, etc)

### This sounds great, why *not* use it?

It's HARD.  Being a meta-tool, it requires knowledge of both Yocto and the individual components of the BSP.

Being an open source project, documentation is tedious and lacking.

It's tempting to choose alternatives for your project structure, but all paths lead to Yocto:

* Rolling your own build system...
  * requires writing script after script after script to do what Yocto already does
  * requires inventing new infrastructure to accompany your project
  * requires bringing outsiders up to speed
  * ends up with something way more complicated than a Yocto project
* Using an OTS Linux distro like Debian...
  * limits what a "stripped down" version of your image will look like 
  * isn't suitable for embedded products
  * probably isn't supported by your HW manufacturer
* Petalinux
  * AMD now maintains [yocto recipes](https://github.com/Xilinx/yocto-manifests) without needing to use Petalinux over top

## Navigating the `pseudo-design-linux` project

* Machines
* Distros
* Images
* Releases (aka branches)
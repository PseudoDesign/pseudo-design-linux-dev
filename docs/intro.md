# Intro to Yocto

## What is Yocto

The [Yocto Project website](https://www.yoctoproject.org/) says:

> The Yocto Project (YP) is an open source collaboration project that helps developers create custom Linux-based systems regardless of the hardware architecture.

> The project provides a flexible set of tools and a space where embedded developers worldwide can share technologies, software stacks, configurations, and best practices that can be used to create tailored Linux images for embedded and IOT devices, or anywhere a customized Linux OS is needed.

In other words, Yocto provides a common interface for embedded Linux developers to share projects.  Typically, this means you have custom hardware featuring an ARM SoC, and you want to build & maintain system images for that hardware.

### Side Note: What is Petalinux?

Petalinux is a catch-all term for Yocto projects targeting Xilinx platforms and using Xilinx tools.  It can mean different things in different contexts, but at the end of the day, it's just Yocto.  We'll discuss the differences as appropriate throughout this document.

## Why use Yocto

### Supported by your HW manufacturer

Not necessarily true for *all* hardware manufacturers, of course.  But if you're here, this is probably true, and your HW manufacturer doesn't want to support anything beyond their published Yocto layer.

### Gives you everything you need (even the stuff you don't know yet!)

* Provides SDK
* Provides software BOM
* Can provide QEMU targets
* Many release artificats (WIC, Software upgrade images, etc)

### Portable, Iteratable, Maintainable

* One project that supports multiple boards (cora-z7, ZCU102, RPI, etc)
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
* Using the typical "Petalinux" tools...
  * Just gives you a less functional, proprietary wrapper around an already functional Yocto ecosystem
  * AMD now maintains [yocto recipes](https://github.com/Xilinx/yocto-manifests) without needing to use Petalinux over top

## Navigating the `pseudo-design-linux` project

* Meta Layers
* Machines
* Distros
* Images
* Releases (aka branches)

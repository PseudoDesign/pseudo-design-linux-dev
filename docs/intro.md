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

* Provides SDK - For free, provided you use the tool correctly
* Provides software BOM - For free, provided you use the tool correctly
* Can provide QEMU targets - Just set it up like any other machine
* Many release artificats (WIC, Software upgrade images, etc)

### Portable, Iteratable, Maintainable

* One project that supports multiple boards (cora-z7, ZCU102, RPI, etc)
* One project that supports multiple images (development, production, vendor-specific, etc)

### This sounds great, why *not* use it?

It's HARD.  Being a meta-tool, it requires knowledge of both Yocto and the individual components of the BSP.

Being an open source project, documentation is tedious and lacking.

Technical debt can snowball fast, where a "bad" Yocto project can take 10x longer to develop for than a "good" project.

It's tempting to choose alternatives for your project structure, but all paths lead to Yocto:

* Rolling your own build system...
  * requires writing script after script after script to do what Yocto already does
  * requires inventing new infrastructure to accompany your project
  * requires bringing outsiders up to speed
  * ends up with something way more complicated than a Yocto project
* Using an OTS Linux distro like Debian...
  * limits what a "stripped down" version of your image will look like 
  * isn't usually suitable for embedded products
  * probably isn't supported by your HW manufacturer
* Using the typical "Petalinux" tools...
  * Just gives you a less functional, proprietary wrapper around an already functional Yocto ecosystem
  * AMD now maintains [Yocto recipes](https://github.com/Xilinx/yocto-manifests) without needing to use Petalinux over-the-top

## Yocto Terms

As a build system, Yocto encourages you to structure your project in a manner compatible with the build system.  When working with Yocto, it's important to use terms as Yocto defines them.  Here are a few terms we'll reference in this document.

* [Recipe](https://docs.yoctoproject.org/ref-manual/terms.html#term-Recipe) - A set of instructions for building a package, using the `.bb` file extension.  These are the smallest unit you'll typically interact with when working within Yocto.
  * If you happen to be familiar with Bazel, these are functionally similar to Bazel's BUILD and MODULE files.
* [Meta Layer](https://docs.yoctoproject.org/ref-manual/terms.html#term-Layer) - A collection of related recipes.  If you're making a one-off project, you'll probably create a single, custom meta layer to track all of your changes.  As time passes and your projects grow more complex, you will create meta layers for each modular component of your projects.
* [Machine](https://docs.yoctoproject.org/ref-manual/variables.html#term-MACHINE) - A target piece of hardware for which your Image is built.  If you're using an eval kit or SoM, the machine-specific definitions are typically provided by the hardware manufacturer.  If you have a custom PCB, you will want to define your own machine layer.  
* [Distro](https://docs.yoctoproject.org/ref-manual/variables.html#term-DISTRO) - A distrobution is a collection of images and packages that are suitable for one or more hardware targets.  `Ubuntu`, `Debian`, and `Arch` are all Linux distributions.  If you wish to implement the same system-level functionalty on multiple MACHINEs, the commonality between them is managed as a unique DISTRO.
* [Image](https://docs.yoctoproject.org/ref-manual/terms.html#term-Image) - A binary output that's run on a specific machine (for example, an SD card image for a Raspberry Pi).  Different images typically include different packages, but still function on multiple machines.  Typically, you'll have a `core-image-minimal` which builds the smallest possible image to boot your system, and `core-image-development`, which additionally includes tools helpful for hardware & software development.
* [Releases](https://wiki.yoctoproject.org/wiki/Releases) - Yocto Projects target releases 4 times a year, and every two years for LTS releases, similar to Ubuntu.  You will overwhelmingly wish to target a LTS releases.  From an orginizational standpoint, meta layers will have branches sharing names of releases it supports, e.g. `scarthgap` and `gatesgarth`.  

I'd also recommend reading at least the bolded portion of the official [What I wish I’d known about Yocto Project](https://docs.yoctoproject.org/what-i-wish-id-known.html) document.  A lot of it will be over your head now, but it's a good document to come back and read every now and then, no matter how much experieince you may have.

## Your First Yocto Project -- `hello-yocto-linux`

When I was first introduced to Yocto, I was put in charge of a project's Yocto build because I was the only person at the company who could even spell "Linux".  Needless to say, I was in way over my head.  This section is the guide I wish I'd have had before I started.  We will go over how to:

* Set up a Yocto project development workspace provided by your hardware manufacturer
* Build an image for that project & install it on your board
* Create a custom meta layer to modify that image
* Build your new image & boot it over the network

### Project Setup

This guide assumes you have an embedded SoC development kit that has a published meta-layer supporting the hardware.  Since *I'm* publishing the meta-layer to support the [cora-z7](https://digilent.com/reference/programmable-logic/cora-z7/start), this guide will target that hardware.  The steps below cover how to set up the project for off-the-shelf Xilinx development kits, such as the `zcu102` or `cora-z7`.  If you're using different hardware, you should start by following their quick-start guide instructions, but still read this section to get a better understanding of the project structure.

Following along with some kind of hardware is helpful. The [Raspberry Pi](https://github.com/agherzan/meta-raspberrypi?tab=readme-ov-file#quick-start) is a good choice if you have one handy.

** This document is a work in progress **

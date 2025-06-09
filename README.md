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
* Set up the development environment: `source sources/meta-pseudo-design/scripts/setupsdk-xilinx workspace/scarthgap/xilinx`
* Compile the minimal cora-z7 image: `MACHINE=cora-z7 bitbake petalinux-image-minimal`

## `repo` development workflow

Think of "repo" as a way to generate pointers to a collection of git repositories.  These are mapped to the development environemnt, as defined in the [manifest repository](https://github.com/PseudoDesign/pseudo-design-linux-manifest).  The  [repo](https://gerrit.googlesource.com/git-repo) tool gives developers an easy mechanism to manage system-level development to a collection of merge requests in the modified repositories.

For example, I modified the various repositories to support configuring the meta-pseudo-design project configuration.  After completing these changes, I could run the `repo status` command to see the changes I made:

```
adam@malak:~/pseudo-design-linux-dev$ repo status
project dev/                                    branch scarthgap
 -m     README.md
project docker/                                 branch scarthgap
project manifest/                               branch scarthgap
 -m     xilinx.xml
project sources/meta-pseudo-design/             (*** NO BRANCH ***)
 --     conf/templates/default/bblayers.conf.sample
 --     conf/templates/default/conf-notes.txt
 --     conf/templates/default/local.conf.sample
 --     conf/templates/default/site.conf.sample
 --     scripts/README.md
 --     scripts/setupsdk-xilinx
```

I can navigate to each of these repositories, and complete the MR process in order to push my updates to the scarthgap branch.  Just use the regular git workflow for this process.

Once all of the `scarthgap` branches are updated for each repository, you can re-initialize your workspace with

`repo sync`
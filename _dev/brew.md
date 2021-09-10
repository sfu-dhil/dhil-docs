---
title: Homebrew
parent: Getting Started
nav_order: 3
layout: default
---

# Homebrew

[Homebrew](https://brew.sh/) is a package manager for OS X. The Homebrew
project collects and distributes open-source packages aimed at
developers. All interaction with Homebrew is via the command line.

<div class="sidebar">

`/usr/local` and `/var` are hidden directories in OS X. They're
available from the command line and can be made visible in the Finder,
but this isn't usually necessary.

</div>

All the Homebrew packages install under `/usr/local` and are configured
to work in that directory as well. For example, MySQL would normally
store its data files in `/var/mysql/data` but Homebrew's MySQL will
store data in `/usr/local/var/mysql`.

If your Homebrew environment ever becomes corrupted you can remove the
entire `/usr/local` directory and start again. Homebrew does not mess
with the OS X system applications at all.

## Installation

The install command is printed on the [Homebrew](https://brew.sh/) home
page, and can be copy/pasted directly into the terminal. It looks like

``` console
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

That one command will download the Homebrew system and put it in the
right place. It may ask for your administrator password, and that's OK.

## Usage

Once it's installed, Homebrew provides the `brew` command which is the
primary way to interact with the package manager. For example, to see a
list of all the installed packages use `brew list`:
```console
    $ brew list
    ant       freetds     libidn2     ncftp       saxon
    (and many many more)
```

This list will be empty if you haven't installed any commands yet.

Brew provides more commands. You can get a list of them via `brew help`
or from the [Homebrew documentation](https://docs.brew.sh/).

<div class="todo">

Bundle as much of this as possible into a Brewfile and include
instructions for using it.

</div>

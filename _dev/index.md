---
layout: default
permalink: /dev/
nav_exclude: true
no_toc: true
---

# Welcome to DHIL's Developer Documentation

# Introduction

This guide assumes you are setting up a development environment for use
in the Digital Humanities Innovation Lab on a Mac. There are many
comparable systems for using Windows or Linux, but we don't have any
users on those systems to test out the documentation. If you'd like to
use those systems and write documentation on your experiences, please
do.

Contributions via our [Github](https://github.com/sfu-dhil) are always
welcome.

## Conventions

<div class="sidebar">

**More information**

Some pages will contain additional information in a sidebar like this.

</div>

File paths are typeset in a `monotype` font in running text to
distinguish them from the surrounding content.

Terminal commands may be referred to inline like `cat /path/to/file` for
a simple description. Longer commands or commands with output are
typeset as in the next example.

``` console
$ ruby --version
ruby 2.0.0p648 (2015-12-16 revision 53162) [universal.x86_64-darwin15]
```

Line 1 above has the command that should be typed, prefixed by a dollar
sign. Don't type the dollar sign as part of the command.

Line 2 has the output from the command. It isn't prefixed with a dollar
sign to indicate that it is output.

<div class="note">

Warnings, notes, and other important information will be included in
notes like this one.

</div>

<div class="todo">

Some parts of the documentation are not as complete or edited as they
should be. Those parts have been noted in these *todo* blocks.

</div>

## Command line

Many of the tools used in this guide are installed, configured, and run
from the command line. You should have a basic familiarity with the
running commands from the terminal.

There are plenty of resources on the Internet to help a person learn to
use the command line and the terminal.

-   <http://blog.teamtreehouse.com/introduction-to-the-mac-os-x-command-line>
-   <https://code.tutsplus.com/tutorials/command-line-basics-and-useful-tricks-with-the-terminal--cms-29356>

<div class="note">

<div class="title">

Note

</div>

OS X includes a usable terminal/command line program at
`/Applications/Utilities/Terminal.app`. It's good enough for most
purposes. If you'd like to use something more sophisticated,
[iTerm2](https://www.iterm2.com/) is a very powerful replacement.

</div>

## Tools

All the tools described by this guide have a common dependency. They
will not work without Apple's XCode tools installed. You don't need the
full, complete XCode suite, just the command line tools. Like everything
else, there's a command to do that.

``` console
$ xcode-select --install
```

XCode is a big piece of software. Expect it to take a long time to
download.

<div class="todo">

Why is xcode needed to run all the tools? Is this something that could
be explained or linked out to another resource? Is it important or
necessary to update xcode based on which version of OSX you are running?
If it is important, I found instruction on how to update xcode command
line tools here:
<https://stackoverflow.com/questions/34617452/how-to-update-xcode-from-command-line>.
--Erik

</div>
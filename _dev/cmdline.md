---
title: The Command Line
parent: Getting Started
layout: default
nav_order: 2
---

# The Command Line

Each operating system has a different set of commands and different ways
to access the command line. The instructions below should work for
[bash](https://www.gnu.org/software/bash/) using systems like Mac OS X,
Linux, and other Unix-ish operating systems.

For Windows users, the easiest way to follow the guide is to download a
bash terminal like [Cygwin](https://cygwin.com/).

In Mac OS X, access to the command line is through a program called
Terminal.app, which is always installed in the Utilities folder, inside
Applications.

**cd**

Changing directories using the command line is done using the `cd`
command, which stands for *change directory*. This is followed by a
space then the directory you would like to move into.

This looks like this:

``` console
$ cd Documents
```

In this case we would like to change directories to the Documents
folder. The `$` represents the command line prompt. When inputting
commands, you do not include the `$`. The first part of this command is
`cd`, which is the change directory command. This is followed by
`Documents`, which is the directory we would like to change into.

**pwd**

When you hit enter to input the command, depending on your command line
set up, nothing will appear on the screen. To check which directory you
are in, you can use the `pwd` command, which stands for *print working
directory*, in other words the folder you are currently in.

In this case, it would look like this:

``` console
$ pwd
/Users/your-username/Documents
```

This shows the full path for your current directory.

If you wish to go up a level to the previous or enclosing directory, you
also use the `cd` command, but you do not need to input a directory
name. In the command line `.` represents your current directory and `..`
represents the parent directory.

To change to the parent directory you can enter the following:

``` console
$ cd ..
$ pwd
/Users/your-username
```

If you then enter `pwd` it will show you that you are back in your home
directory.

**ls**

If you want to know the contents of a given directory, you can use the
`ls` command, which stands for *list directory*. When you enter `ls` it
will show you all the files and directories that are contained within
your current directory.

This looks like the following:

``` console
$ ls
Applications  Desktop  Documents  Downloads  my_thesis.txt
```

This is helpful for determining what is in your current directory.

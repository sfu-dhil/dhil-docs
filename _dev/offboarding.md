---
title: Offboarding
parent: Cleaning Up
layout: default
nav_order: 1
---

# Offboarding

This page contains instructions on how to remove the Digital Humanities
Innovation Lab's developing environment from your computer. The current
instructions are only for Mac computers. Tools are presented in the
order they should be removed.

All of the DHIL applications are Open Source. You can take them with you
if you'd like. Removing them and the development environment is
optional.

## Sphinx and Python

As python and Sphinx are installed using Homebrew, if you remove all
Homebrew packages and uninstall Homebrew, python and Sphinx will also be
uninstalled. However, if you wish to keep Homebrew and only remove
python and Sphinx, you can do so using the following command

Sphinx is a python package. If you wish you keep Homebrew and the
Homebrew installation of Python but remove Sphinx, you can do so using
python's package manager.

``` console
$ pip3 uninstall Sphinx
```

This will remove Sphinx but will not affect Homebrew or your Homebrew
installation of python.

``` console
$ brew uninstall python --force
```

`--force` is required to ensure all Homebrew versions of python are
uninstalled. Otherwise, Homebrew will continue to install the latest
version of python (or any package) that it knows about when you update
all packages using `brew upgrade`.

## MySQL

MySQL runs as a background service. You must stop the background service
before removing it.

``` console
$ brew services stop mysql@5.7
$ brew uninstall --force mysql@5.7
$ rm -rf /usr/local/var/mysql
```

Line 1 stops the MySQL process and unloads it from memory. Line 2
removes the MySQL server files, but does not remove any of the MySQL
data files. Line 3 clears out all of the MySQL database files.

## PHP

The set-up guide for PHP includes the PHP installation as well as the
installation of a number of PHP extensions. PHP and the extensions
(pkg_config, imagemagick, and composer) can be uninstalled using
Hombrew. To remove all four packages, run

``` console
$ brew uninstall php@5.6 pkg_config imagemagick composer --force
```

This will also remove all configuration files edited when installing
`section-php`.

## Node and Node Tools

If you've followed this guide, NodeJS is just another Homebrew package,
and can be removed like all the rest. This will also uninstall the Node
Package Manager (npm).

``` console
$ brew uninstall node
```

This command won't touch any of the Symfony applications you've
downloaded to your computer, and that's probably a good thing.

## Apache

Apache was installed using Homebrew so you can use Homebrew to remove
it. The command is

``` console
$ brew services stop httpd
$ brew uninstall httpd --force
```

This will also remove all configuration files edited when installing
`section-apache`.

## Git

Git was installed using Homebrew so you can use Homebrew to remove it.
The command is

``` console
$ brew uninstall git --force
```

## DHIL Symfony Apps

If you have been following this guide, all Symfony apps will be held
within the `~/Sites` directory. To uninstall the app from your computer
you will need to:

> -   Delete the app from the `~/Sites` directory
> -   Remove the database and user from MySQL.

To remove the app from the command line, enter the following command
where `app_name` is the name of the app directory.

``` console
$ rm -rf ~/Sites/app_name
```

If you are completely removing MySQL, you will not need delete
individual databases as they will be removed when MySQL is deleted. If
you would like to remove the databse for a single app, complete the
following steps.

## Xcode Command Line Tools

If you installed the XCode command line tools following the instructions
in this guide, you can uninstall it by removing the
`/Library/Developer/CommandLineTools` directory. The command looks like

``` console
$ sudo rm -rf /Library/Developer/CommandLineTools
```

You will need to run this command using sudo, which will prompt you for
your administrator password.

## Homebrew

You can uninstall Homebrew using the uninstall command that is printed
on the [Homebrew FAQs](https://docs.brew.sh/FAQ) page. It looks like

``` console
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
```

That command will attempt to uninstall and remove all homebrew
pacakages. If it does not completely remove all packages, you may need
to run the command using sudo, which will prompt you for your
administrator password.

---
title: PHP
parent: Getting Started
layout: default
nav_order: 5
---

# PHP

Mac OS X includes a version of PHP which is often out of date. Luckily
Homebrew makes installing another PHP very easy.

## Installation

The DHIL production server runs PHP 7, so we will install that.
installing other versions of PHP is possible and quite easy. See below
for more information.

``` console
$ brew install php pkg-config imagemagick composer
$ pecl install imagick
```

Line 1 installs PHP and friends. The install command will print a lot of
information to the terminal which you can mostly ignore. It will also
install a PHP package manager called `pecl` which we will use in step 2.

Line 2 installs the PHP extension that uses imagemagick. It uses PHP's
package manager to download and configure it. The command will ask for a
path to the imagemagick library. Press enter to accept the default
(autodetect) which should find the library.

## Configuring

The pecl install step (line 4 above) will automatically configure PHP to
find the imagick extension. Other configuration options are available in
`/usr/local/etc/php/7.2/php.ini`

You must set the timezone in the `php.ini` file. Open the file in your
text editor, and find the `[Date]` section.

``` ini
[Date]
; Defines the default timezone used by the date functions
; http://php.net/date.timezone
;date.timezone =
```

Uncomment line 4 by removing the semicolon at the start of the line,
then add "America/Vancouver" to the end. The result should be

``` ini
[Date]
; Defines the default timezone used by the date functions
; http://php.net/date.timezone
date.timezone = America/Vancouver
```

Other recommended settings are:

* `memory_limit = 128M` Change this to 256M or higher.
* `html_errors = On` Change this to Off.
* `post_max_size = 8M` Change this to 64M or higher.
* `upload_max_filesize = 2M` Change this to 60M or higher. It should be less than the value of `post_max_size`.

## Test PHP

PHP includes a few command line tools. These sample commands should all
work and print useful things. If you try these commands and get an error
message, something has gone wrong in the installation.

``` console
$ php --version
PHP 7.2.6 (cli) (built: Jun 22 2018 00:08:38)
(and less useful output)

[14:02:03][michael@sophie devenv]$ php -m
[PHP Modules]
bcmath
bz2
calendar
Core
(and many many more)
```

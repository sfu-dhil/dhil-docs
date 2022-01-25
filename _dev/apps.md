---
title: Installing a DHIL Symfony App
parent: Getting Started
layout: default
nav_order: 9
---

# Installing a DHIL Symfony App

Each project should have its own documentation, including instructions
for [getting the source
code](https://github.com/sfu-dhil/ceww-docs/blob/master/source/install.rst)
from GitHub. We also publish that documentation on the [project
website](https://dhil.lib.sfu.ca/doceww/docs/html/install.html). Those
instructions are summarized here for convenience.

The following instructions use the Database of Canada's Early Women
Writers (ceww) project as an example. You may need to change `ceww` to
something else for a different project.[1]

1. Log in to Github's website and create a fork of the project. There's
    a "Fork" button in the project's repository page for this.

2. Clone your fork to your computer. The code below will fetch the
    submodules and set them up correctly.
    
     ```console
     $ git clone --recursive git@github.com:USERNAME/ceww.git
     ```
    
3. Create a database and database user in mysql. These are sample
    commands.

``` console
$ mysql
CREATE DATABASE doceww;
CREATE USER doceww@localhost IDENTIFIED BY 'abc123';
GRANT ALL ON doceww.* TO doceww@localhost;
```

4. Install the composer dependencies. These are PHP packages and
    libraries that provide functionality like database connectivity and
    logging and many other good things.

``` console
$ composer install
```

    Sometimes Composer runs out of memory. If that happens, try this
    alternate.

``` console
$ php -d memory_limit=-1 `which composer` install
```

5. Update file permissions if needed. If you followed the directions in
    the [Apache]({{site.baseurl}}{% link _dev/apache.md %}) section this should not be necessary.

    The user running the web server must be able to write to these 
    directories:
   1. var/cache
   2. var/log
   
   The symfony docs provide
       [recommended
       commands](http://symfony.com/doc/current/setup/file_permissions.html)
       depending on your OS.

   And if you're working on an application that takes file uploads, you
   may need to give additional permissions to the file upload
   directory. Check the documentation.

6. Install the yarn dependencies. These are javascript and CSS packages like Bootstrap.

```console
$ yarn
yarn install v1.22.17
[1/4] 🔍  Resolving packages...
[2/4] 🚚  Fetching packages...
[3/4] 🔗  Linking dependencies...
[4/4] 🔨  Building fresh packages...
✨  Done in 10.36s.
```

8. Load the schema into the database. This is done with the Symfony
    console.

``` console
$ ./bin/console doctrine:schema:update --force
```

8. At this point, the web interface should be up and running, and you
    should be able to load some pages. The URL for the app should be
    something like <http://localhost/ceww/public/>

    <div class="note">
    If you're a pleb without access to port 80:
    <http://localhost:8080/ceww/public/>
    </div>

9. Create an application user with full admin privileges. This is also
   done with the Symfony console.

``` console
$ ./bin/console fos:user:create admin@example.com
$ ./bin/console fos:user:promote admin@example.com ROLE_ADMIN
```

   You should now be able to login to the app by following the Login
   link in the top right corner of any application page.

10. Hack and slash your way through the code. The source code for
    symfony apps is very organized. Application configuration is in
    `config`. Actual runnable source code is in `src`.
    Tests for the code lives in `tests`.

11. Run some tests. The composer dependencies include PHPUnit for
    testing. The source code includes all the tests, and should always
    be runnable.

     ``` console
     $ ./vendor/bin/phpunit
     PHPUnit 5.7.27 by Sebastian Bergmann and contributors.
    
     ...............................................................  63 / 434 ( 14%)
     ............................................................... 126 / 434 ( 29%)
     ............................................................... 189 / 434 ( 43%)
     ............................................................... 252 / 434 ( 58%)
     ............................................................... 315 / 434 ( 72%)
     ............................................................... 378 / 434 ( 87%)
     ........................................................        434 / 434 (100%)
    
     Time: 1.7 minutes, Memory: 354.75MB
    
     OK (434 tests, 775 assertions)
    ```

    The git repositories contain a default config file called
    `phpunit.xml.dist`. If you want to customize the configuration, copy
    the file to `phpunit.xml` and configure as needed. Git will ignore
    the `phpunit.xml` file.

12. Keep your code clean. Each Symfony includes a configuration file for PHP 
    CS Fixer. It's a tool that parses PHP files and applies coding standards 
    to them. It will tidy up any odd whitespace and check for common coding 
    errors.

    ```console
    $ php-cs-fixer fix
    Loaded config default from ".php-cs-fixer.dist.php".
    Using cache file "var/cache/php_cs.cache".
    1) src/Command/ExportBatchCommand.php
    1) migrations/2021/09/Version20210910223644.php

    Fixed all files in 5.137 seconds, 18.000 MB memory used
    ```

**Footnotes**

[1] The repository name for the DoCEWW project is ceww for historical
reasons. It should be doceww to be consistent with the proper name of
the project. The name is consistent in the canonical URL:
<https://dhil.lib.sfu.ca/doceww>

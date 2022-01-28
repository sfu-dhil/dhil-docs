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
something else for a different project.[^1]

## Getting the Code

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

4. The project directory should include a file called `.env`. 
   Make a copy of this file and call it `.env.local`:

    ```console
    $ cd ceww
    $ cp .env .env.local
    ```

5. Determine your database server implementation and version, which you 
   will need later, by running `mysql --version` at the command line. We 
   recommend you [install the MariaDB]({{ site.baseurl}}{% link _dev/mysql.md %}) 
   implementation of MySQL. The output for 
   MariaDB will be something like this, which shows MariaDB version 10.6.4.

    ```
   $ mysql --version
    mysql  Ver 15.1 Distrib 10.6.4-MariaDB, for osx10.16 (x86_64) using readline 5.1
    ```

6. In `.env.local`, you should see the  `DATABASE_URL` field that has generic values:

    ```text
    DATABASE_URL=mysql://db_user:db_password@127.0.0.1:3306/db_name?serverVersion=5.7
    ```

    Replace `db_user` with the database user, `db_password` with the password, 
    and `db_name` with the database's name. You will also need to change the
    `serverVersion`.

    ```text
    DATABASE_URL=mysql://ceww:abc123@127.0.0.1:3306/ceww?serverVersion=10.6.4-mariadb
    ```

7. In `.env.local`, change `ROUTE_HOST` to `localhost` and `ROUTE_BASE` to the project's base (usually
   something like `projectName/public`):

    ```text
    ROUTE_PROTOCOL=http
    ROUTE_HOST=localhost
    ROUTE_BASE=/ceww/public
    ```

## Setting up the Project

1. Install the composer dependencies. These are PHP packages and
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

## Getting the Data

Once you have downloaded the application, you will need a copy of the existing data
from the DHIL's server. Note that you will also need adequate permissions to the DHIL's
server to access the data. 

1. If you're not already, log in to SFU's VPN using Forticlient

2. In a terminal window, log in to the DHIL server:

    ```console
    $ ssh username@dhil.lib.sfu.ca
    ```

    <div class="note">
    The server log in process can be complicated and may require some careful configuration beforehand. If in doubt,
    talk to a DHIL developer or Library Systems about accessing the DHIL server.
    </div>

3. In a *separate* terminal window, navigate to the project's repository and open the `config/deploy.yaml`
    configuration file.

4. Configure the deployment: In the project's repository, navigate to `config/deploy.yaml` and change 
   all of the `user` properties to your SFU id

5. In the root of the project's repository, fetch the database backup. It 
   comes in two parts, one file for the schema and one for the data.

    ```console
    $ dep dhil:db:fetch dhil
    ➤ Executing task dhil:db:schema
    Downloaded database dump to ceww-schema-2022-01-28-dhil-r116.sql
    ✔ Ok
    ➤ Executing task dhil:db:data
    Downloaded database dump to ceww-data-2022-01-28-dhil-r116.sql
    ✔ Ok 
    ```


6. Upload the data dump into mysql. If you've set fairly lax permissions locally, you can usually do
   this by doing something like:
    
   ```console
    $ mysql ceww < ceww-schema-2022-01-28-dhil-r116.sql
    $ mysql ceww < ceww-data-2022-01-28-dhil-r116.sql
    ```

   For larger projects, it's often useful to track the upload progress using `pv`:

    ```console
    $ pv ceww-data-2022-01-28-dhil-r116.sql | mysql ceww
    768KiB 0:00:09 [0.00 B/s] [======>                            ] 20% ETA 0:00:35
    ```

7. At this point, the web interface should be up and running, and you
    should be able to load some pages. The URL for the app should be
    something like <http://localhost/ceww/public/>

    <div class="note">
    If you're a pleb without access to port 80:
    <http://localhost:8080/ceww/public/>
    </div>

## Working on the Project

1. Create an application user with full admin privileges. This is also
   done with the Symfony console.

    ``` console
    $ ./bin/console nines:user:create admin@example.com
    $ ./bin/console nines:user:promote admin@example.com ROLE_ADMIN
    $ ./bin/console nines:user:activate admin@example.com
    $ ./bin/console nines:user:password admin@example.com supersecret
    ```

   You should now be able to login to the app by following the Login
   link in the top right corner of any application page.

2. Hack and slash your way through the code. The source code for
    symfony apps is very organized. Application configuration is in
    `config`. Actual runnable source code is in `src`.
    Tests for the code lives in `tests`.

3. Run some tests. The composer dependencies include PHPUnit for
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

4. Keep your code clean. Each Symfony includes a configuration file for PHP 
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

[^1]: 
    The repository name for the DoCEWW project is ceww for historical  reasons. 
    It should be doceww to be consistent with the proper name of the project.
    The name is consistent in the canonical URL: <https://dhil.lib.sfu.ca/doceww>
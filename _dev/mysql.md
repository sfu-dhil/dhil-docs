---
title: MySQL
parent: Getting Started
layout: default
nav_order: 4
---

# MySQL

There are many versions of MySQL available via Homebrew, and they are
mostly compatible with each other and with our production server. This
document describes installing the MariaDB fork of MySQL, because that's 
what we have elsewhere. If that version doesn't work, feel free to try 
another version. 

## Installation

``` console
$ brew install mariadb
$ brew services start mariadb
```

Line 1 above installs MariaDB.

Line 2 enables it as a background service and registers it to start
automatically at login.

In the remainder of this documentation, we will use MariaDB
and MySQL interchangeably.

Now it's time to test the installation.

``` console
$ mysql -u root
```

This should start a MySQL console in the terminal that looks something
like this:

    $ mysql -u root
    Welcome to the MariaDB monitor.  Commands end with ; or \g.
    Your MariaDB connection id is 47
    Server version: 10.6.4-MariaDB Homebrew
    
    Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.
    
    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
    
    [10:05:13][root@localhost] (none) >

The `mysql>` line is the command prompt. MySQL is waiting for a command
at that prompt. Type `ctrl-d`[^1] to exit the MySQL console and return to
your normal console.

## Make it secure

MySQL is installed without a password and with only a root user. It must
be made secure.

``` console
$ mysql_secure_installation
```

The `mysql_secure_installation` command will ask a few questions about
configuring the MySQL server. Recommended settings include:

 -   **Do not** install the Validate Password plugin.
 -   **Do** set a memorable password for the root account. Use a  password that is different from any other password you use to login.
 -   **Do** remote the anonymous users.
 -   **Do not** allow remote users to login[^2].
 -   **Do** remove the test database and access to it.
 -   **Do** reload the privilege tables.

With these settings, only a user logged in to your computer can access
the database, and must provide a password you assign to do so.

## Configure the Server

MySQL's configuration is complex, and can be defined in a number of
different places, depending on which part of the server is being
configured.

To configure the server, edit `/usr/local/etc/my.cnf` in your favourite
text editor. The file may be empty, and might not even exist. That's OK.
The recommended configuration is below.

``` ini
[mysqld]
bind-address = 127.0.0.1
socket = /tmp/mysql.sock
general_log = 0
general_log_file = /usr/local/var/log/mysql/general.log
log_error = /usr/local/var/log/mysql/error.log
log_queries_not_using_indexes = 1
log_warnings = 2
lower_case_table_names = 2

slow_query_log = 0
slow_query_log_file = /usr/local/var/log/mysql/slow.log

sql_mode = "STRICT_ALL_TABLES,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_AUTO_VALUE_ON_ZERO,NO_ENGINE_SUBSTITUTION"
```

Line 1 marks the configuration as applying only to the MySQL server,
instead of the client or other programs.

Line 2 prevents access to the server from outside your computer.

Line 3 defines where mysql will listen for connections through its
socket.

Lines 4 & 5 disable the general log, but provide a default location for
it anyway. The general log has too much information for normal use, but
can be useful for debugging.

Lines 6 to 8 enable the error log and set the error log location.

Line 9 makes sure table names are stored in lower case. Mixed case names
are a problem in some operating systems.

Lines 11 & 12 do the same thing for the slow query log. It's useful for
tracking down problems but usually isn't necessary.

Line 14 sets the SQL server mode, which is fairly strict. It will
prevent most common errors but also allow us to use dates with zeros in
them like `1852-00-00` when the month and day are unknown.

This configuration will send log files to `/usr/local/var/log/mysql`. That
directory doesn't exist, so create it and set the permissions on it now.

``` console
$ sudo mkdir -p /usr/local/var/log/mysql
$ sudo chown USERNAME:staff /usr/local/var/log/mysql
```

Once the file is in place, MySQL will need to be restarted for the
configuration to become active.

``` console
$ brew services restart mariadb
```

## Make it easier to use

MySQL's tools will look in your home directory for a file called
`.my.cnf` which may contain additional settings and configuration. You
can use this file to automatically supply a username and password when
connecting to the server.

Use the editor of your choice to edit the file. It is divided up in to
sections, with one section for each mysql command you configure. Here
are some suggested contents with descriptions

``` ini
[mysql]
prompt=mysql \d >
user=root
password=abc123
default_character_set=utf8
```

Line 1 starts the `mysql` section. The options in this section will
apply to that command only.

Line 2 adds the current database name to the command prompt in the MySQL
console.

Lines 3 and 4 set the connection parameters, so you can connect without
passing the username and password at the command line.

Line 5 sets the character encoding to UTF-8. This keeps everything consistent.

There's no need to restart MySQL after changing this file in your home
directory.

## Use MySQL

The database is fairly easy to use from the command line if you've
configured it as above. Type `mysql` and get a prompt. Type `mysql name`
to connect to the named database.

There are other tools to connect to MySQL.
[MySQLWorkBench](https://www.mysql.com/products/workbench/) provides a
nice GUI to browse databases and tables, and can perform useful
management operations on them.
[Netbeans](https://netbeans.org/projects/www/) provides a useful GUI as
well, although it is a bit less sophisticated. It's also a very powerful
PHP editor.

Each project that uses MySQL has installation instructions specific to
that project. The documentation will guide you through creating a
database, adding a database-specific user, setting permissions for that
user, and setting a password for that user.

<div class="todo">

Include a mention of `mysqldump` for creating backups and how to load
those backups back into MySQL.

</div>

**Footnotes**

[^1]: 
    `ctrl-d` means to hold down the control key and type d.

[^2]: 
    The wording of the question in the command is a bit odd:
    "Disallow root login remotely?" Answer **y** to this question.

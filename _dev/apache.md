---
title: Apache
parent: Getting Started
layout: default
nav_order: 7
---

# Apache

You should have working installs of MySQL and PHP at this point. The
server software to install is called Apache, but the name of the service
is httpd.

## Installation

Install the basic Apache web server.

{% highlight console linenos %}
$ brew install httpd
$ sudo brew services start httpd
{% endhighlight %}

Line 1 will install the server and configure the defaults for Apache to
listen on port 8080. This is the same port that eXist-db will listen on
and may cause conflicts later. We will fix this by changing the Apache
port later.

Line 2 will start the server. `sudo` will run the command as root, to
ensure that all permissions are set up correctly.

At this point you should be able to visit <http://localhost:8080> in a
web browser and see that it works.

## Configuration

The apache config file is /usr/local/etc/httpd/httpd.conf. Open it in a
text editor and make the following changes.

<div class="note">
If you don't have access to port 80, maybe because the people that
control things don't want to give out that kind of access, skip this
step. Make sure that you take note of the fact that you skipped the
step. Jump down to "Change where Apache will find documents."
</div>

1.  `Listen 8080`  
    Change this to `Listen 80`.

    <div class="note">
    If you don't have access to port 80, maybe because the people that
    control things don't want to give out that kind of access, skip this
    step. Make sure that you take note of the fact that you skipped the
    step.

    You should also note this if you work with [eXistDb]({{ site.baseurl }}{% 
    link _dev/exist.md %}) which also listens on port 8080. If you need to run 
    both Apache and eXist at the same time, make sure you change one of their
    configurations to listen on a different port.
    </div>

2.  `User _www`  
    Change `_www` to your user name.[^1]

3.  `Group _www`  
    Change `_www` to `staff`.

Uncomment these lines by removing the '#' character.

1.  `#ServerName www.example.com:8080`  
    Also change **www.example.com:8080** to `localhost`

    <div class="note">
    If you skipped step 1, skip this step as well.
    </div>

2.  `#LoadModule rewrite_module lib/httpd/modules/mod_rewrite.so`  
    Remove the leading `#`. No other changes are necessary for this
    line.

Change where Apache will find documents to serve. Find the DocumentRoot
section of the configuration file. It will look like this:

{% highlight apacheconf linenos %}
DocumentRoot "/usr/local/var/www"
<Directory "/usr/local/var/www">
    #
    # Possible values for the Options directive are "None", "All",
    # or any combination of:
    #   Indexes Includes FollowSymLinks SymLinksifOwnerMatch ExecCGI MultiViews
    #
    # Note that "MultiViews" must be named *explicitly* --- "Options All"
    # doesn't give it to you.
    #
    # The Options directive is both complicated and important.  Please see
    # http://httpd.apache.org/docs/2.4/mod/core.html#options
    # for more information.
    #
    Options Indexes FollowSymLinks

    #
    # AllowOverride controls what directives may be placed in .htaccess files.
    # It can be "All", "None", or any combination of the keywords:
    #   AllowOverride FileInfo AuthConfig Limit
    #
    AllowOverride None

    #
    # Controls who can get stuff from this server.
    #
    Require all granted
{% endhighlight %}

Change it to the following. Changed lines are highlighted. Use your
login in place of `username` on lines 1 and 2.

{% highlight apacheconf linenos %}
DocumentRoot "/Users/username/Sites"
<Directory "/Users/username/Sites">
    #
    # Possible values for the Options directive are "None", "All",
    # or any combination of:
    #   Indexes Includes FollowSymLinks SymLinksifOwnerMatch ExecCGI MultiViews
    #
    # Note that "MultiViews" must be named *explicitly* --- "Options All"
    # doesn't give it to you.
    #
    # The Options directive is both complicated and important.  Please see
    # http://httpd.apache.org/docs/2.4/mod/core.html#options
    # for more information.
    #
    Options All FollowSymLinks Multiviews
    MultiviewsMatch Any

    #
    # AllowOverride controls what directives may be placed in .htaccess files.
    # It can be "All", "None", or any combination of the keywords:
    #   AllowOverride FileInfo AuthConfig Limit
    #
    AllowOverride All

    #
    # Controls who can get stuff from this server.
    #
    Require all granted
</Directory>
{% endhighlight %}

These changes will configure Apache to listen on port 80, which is the
usual port for a web server. It will serve files from the `Sites`
directory in your home directory. Anything you place in that directory
will be available to the public.

Finally, create the Sites folder if it doesn't already exist and add
some content to it.

``` console
$ mkdir -p ~/Sites
$ echo "<h1>Howdy do!</h1>" > ~/Sites/index.html
```

<div class="note">
The tilde (`~`) character has special meaning: It represents your home
directory. So \~/Sites is the Sites directory inside your home
directory.
</div>

Once these changes are complete, you must restart Apache for them to
take effect.

``` console
# If you have access to sudo and port 80
$ sudo brew services start httpd
# If you lack the god-like powers bestowed by "the others"
$ brew services start httpd
```

Now if you visit <http://localhost> you should see "Howdy do!" in the
page.

<div class="note">

If you skipped changing the port number to 80 above, you should visit
<http://localhost:8080> instead.

</div>

## Add PHP to Apache

At this point Apache can serve static files like images or text to a
browser. It cannot generate a web page or run a program. To do that we
must add the PHP module to Apache.

Add this text, as it is, to the httpd.conf file.

```
LoadModule php7_module /usr/local/opt/php/lib/httpd/modules/libphp7.so
<FilesMatch \\.php$>
  SetHandler application/x-httpd-php
</FilesMatch>
```

Finally, test that Apache and PHP work together.

``` console
$ sudo apachectl restart
$ echo "<?php phpinfo();" > ~/Sites/info.php
```

Now you should be able to visit <http://localhost/info.php> to see some
very useful information about your PHP installation.

<div class="note">

Maybe you like to skip steps and should visit
<http://localhost:8080/info.php> instead.

</div>

## Troubleshooting

Check if Apache is running at all.

``` console
$ ps ax  | grep httpd
34512   ??  Ss     0:00.08 /usr/local/opt/httpd/bin/httpd -D FOREGROUND
34515   ??  S      0:00.00 /usr/local/opt/httpd/bin/httpd -D FOREGROUND
```

Read the apache error log. The most recent error output is at the end of
the log.

``` console
$ open -a Console.app /usr/local/var/log/httpd/error_log
```

Check the Apache configuration.

``` console
$ sudo apachectl -S
VirtualHost configuration:
ServerRoot: "/usr/local/opt/httpd"
(and many more lines)
```

Commands to Start, stop, or restart the web server are below. If you do not 
have permissions to use sudo, don't include it.

``` console
$ sudo brew services start httpd
$ sudo brew services stop httpd
$ sudo brew services restart httpd
```

**Footnotes**

[^1]: 
    Use the `whoami` command to find your username if you 
    aren't sure.

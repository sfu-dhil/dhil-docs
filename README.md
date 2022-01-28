# Documentation for the DHIL

To build this documentation, first download Jekyll following the
instructions here: https://jekyllrb.com/docs/installation/

Mac OS comes with ruby already, but it may be prudent to have a higher version.
In that case, you can `brew install ruby` and then add the following to your shell's
profile:


```bash
PFX=$(brew --prefix)
if [ -d "$PFX/opt/ruby/bin" ]; then
  export PATH=$PFX/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi
```

For safety's sake, you may want to set the bundler to put gems locally before
doing a bundle install:
```bash
# If you'd like to have the gems locally rather than globally
bundle config set --local path 'vendor/bundle'
bundle install
````

In most cases, the easiest way to build the site is to serve it on its own:

```console
$ bundle exec jekyll serve
```

You should be able to the view the site at this URL from the `Server address` 
line in the output:

``console
Server address: http://127.0.0.1:4000/dhil-docs/
``

The server will stay open and site will update automatically until you close the connection (either by exiting
the terminal window or `ctrl-c`).

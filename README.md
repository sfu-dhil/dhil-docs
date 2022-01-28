# Documentation for the DHIL

To build this documentation, first download Jekyll following the
instructions here: https://jekyllrb.com/docs/installation/

Mac OS comes with ruby already, but it may be prudent to have a higher version.
In that case, you can `brew install ruby` and then add the following to your shell's
profile:


```bash
## Ruby 
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
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

Since the site has some odd GitHub specific server configurations, 
the easiest way to build the site is to serve it on its own:

```
bundle exec jekyll serve
```

That will likely serve it on `localhost:4000/dhil-docs`

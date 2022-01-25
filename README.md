# Documentation for the DHIL

To build this documentation, first download Jekyll following the instructions here: https://jekyllrb.com/docs/installation/

Note that on Mac OSX Big Sur (or higher), you may need to
put your Gem directory in your $PATH:

```bash
# In your  .bash_profile
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
```

Once installed, install the Jekyll dependencies:

```bash
bundle install
```

Since the site has some odd GitHub specific server configurations, the easiest way to build the site is to serve it on its own:

```
bundle exec jekyll serve
```

That will likely serve it on `localhost:4000/dhil-docs`

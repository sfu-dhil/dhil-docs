# Sphinx

[Sphinx](http://www.sphinx-doc.org/en/master/) is our documentation
system.

## Install

1.  Install homebrew python

``` console
$ brew install python
```

That may take some time. By default Homebrew installs Python v3.x. This
is the version you want for installing and runing Sphinx.

2.  Use python's package manager to install Sphinx

``` console
$ pip3 install Sphinx
```

## Usage

The documentation repositories are pre-configured for sphinx installed
as above and include a build setup. Generate the HTML documentation like
so:

``` console
$ make html
```

The documentation will then be available in `build/html/index.html`.
Some projects have been configured to output the documentation to the
`web/docs/` directory.

<div class="seealso">

For more information, check out the [First Steps with
Sphinx](http://www.sphinx-doc.org/en/stable/tutorial.html)
documentation.

</div>

<div class="note">

<div class="title">

Note

</div>

If you are using the [Atom](https://atom.io/) editor with the
[ReStructuredText Preview
package](https://atom.io/packages/rst-preview), you may also need to
install [pandoc](https://pandoc.org/). The extension uses it, instead of
Sphinx, to create previews.

``` console
$ brew install pandoc
```

</div>

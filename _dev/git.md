---
title: Git
parent: Getting Started
layout: default
nav_order: 8
---

# Git

All of the DHIL projects use Git for version control.

## Installation

Mac OS X provides a `git` command as part of the XCode suite. It is
usually out of date, so it's best to install Git from Homebrew.

``` console
$ brew install git
$ git --version
git version 2.18.0
```

## Global Configuration

You can define a default global git configuration in your home
direction. Each project managed by git can override any of the
configuration options. Open `$HOME/.gitconfig` and add some lines like
this:

``` ini
[user]
      name = BOB TERWILLIGER
      email = bob@springfield.com

[core]
      excludesfile = ~/.gitignore_global
      editor=/usr/bin/atom

[github]
      user = BOBTER
```

These settings will add your name and email address to commits, and will
ignore any file pattern found in $HOME/.gitignore_global. It will also
configure a default Github username for any interactions with Github.

You can now edit `$HOME/.gitignore_global` to make sure git ignores some
files.

``` ini
*~
*.log
```

This setup will ignore any file that ends in a tilde (\~) and any log
file.

## Encryption Keys

Command line git is easiest to use when you've set up ssh keys. They
enable secure password-less communication between computers.

<div class="sidebar">

**Existing Keys**

You might already have a public/private key pair. Check for them like
so:

    $ ls ~/.ssh/

If the output includes a file called `id_rsa.pub` you can skip this
step.

</div>

Start by generating a public/private key pair. The command below will
ask some questions. Press enter to accept the defaults. There will be a
lot of output, so only the important lines are shown below.

``` console
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/USERNAME/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /Users/USERNAME/.ssh/id_rsa.
Your public key has been saved in /Users/USERNAME/.ssh/id_rsa.pub.

(lots of output cut)

$ ls ~/.ssh/
id_rsa          id_rsa.pub
```

Success. From this point forward, git will attempt to use the ssh keys
generated above to interact with servers.

## Create a Github Account

We use [GitHub](https://github.com) to manage most of our souce code.
Visit the website, sign up, and we will add you as a contributor to the
[SFU DHIL account](https://github.com/sfu-dhil).

<div class="sidebar">

**Hidden Files and Directories**

File and directory names that start with a dot(.) are hidden. The OS X
Finder won't show you these directories by default. One example is the
`.ssh` directory inside your home directory. You can open that directory
in the finder: `open ~/.ssh` to see the contents.

</div>

Once you've signed up for an account you should add your SSH public key.
It lives in `/Users/USERNAME/.ssh/id_rsa.pub`. That's inside a hidden
directory. To open it, return to the command line.

<div class="note">

<div class="title">

Note

</div>

In the next example, the public key file is named `id_rsa.pub`. It is
perfectly safe to distribute this key to the world. There's also a file
in the directory called `id_rsa` (note the missing `.pub` suffix). This
file must be kept private and confidential.

</div>

``` console
$ cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDf/SMEHG3tLUDDVwbBAlZNJTrS24enBBwV
dfkuTXDRBtSaeCt0ImuQfi6hNE9Kl0W6E0rnbu3itM7uqnNF3AcexHKHwUawjFPCRmEO8Dx+
tOmQX0cbMUeCuMcV7wRMmCSjRY9p781X1wqGw6pYA4DeuFqtTzctmOsXMqsZig28USNYvXIc
VkevWoJzZn4ftfMbnkkrGR6B7H4D8z3Pw98MisM4M2jN8/8GbTHFSKawNmY2Guy+hT9ndinX
Rs0I5thvpDqLsVS1z1+9NGmJgM5x/LTyOjgO0DwNx5q/uU2BmImu8MQEA9qe5sZ0bddtpiL6
xh5LyRJpv1RB+Yyc6x3b USERNAME@COMPUTERNAME
```

Open your [Github Profile](https://github.com/settings/profile) page,
navigate to the SSH & GPG keys section. Copy and paste the contents of
the key (from `ssh-rsa` to `USERNAME@COMPUTERNAME`) into the box, and
give the key a name.

You can have multiple public keys registered in GitHub, but this is
really only useful if you have multiple computers.

## Using Git and Github

Many of the projects use a bunch of similar functionality. Rather than
recreating very similar code in each project it is grouped together into
git submodules. That way each project can share the functionality and
bug fixes quite easily.

We prefer smaller commits that contain a completed feature or fix a bug
to larger commits that address many different concerns. Smaller commits
are easier to read and review, and finding the source of a problem is
easier if the commits are smaller.

Once git and github are configured, the `section-apps` documentation
should help you get an app set up. But to quickly summarize:

<div class="note">

<div class="title">

Note

</div>

So far we haven't been working in git branches in the DHIL, but we
really should. The documentation below assumes you are working in the
default branch.

</div>

1.  Create a fork of a project in GitHub.

2.  Clone your fork to your computer, and work in the fork.

    > ``` console
    > $ git clone --recursive git@github.com:USERNAME/PROJECT.git
    > (useless output goes here)
    > $ cd PROJECT
    > ```

3.  Add the upstream repository to your git repository. This will let
    you keep your fork up to date with the DHIL repository.

    > ``` console
    > $ git remote add upstream http://github.com/sfu-dhil/PROJECT.git
    > ```

4.  Do all of the configuration steps to get the project working.

5.  Edit the source code. Don't forget to write tests.

6.  Check on the status of your files.

    > ``` console
    > $ git status
    > On branch master
    > Your branch is up to date with 'origin/master'.
    >
    > Changes not staged for commit:
    > (use "git add <file>..." to update what will be committed)
    > (use "git checkout -- <file>..." to discard changes in working directory)
    >
    > modified:   bower.json
    >
    > no changes added to commit (use "git add" and/or "git commit -a")
    > ```

7.  Make some commits in the fork.

    > ``` console
    > $ git commit -m "Update the bower metadata." bower.json
    > [master 1791385] Update the bower metadata.
    > 1 file changed, 2 insertions(+), 2 deletions(-)
    > ```

8.  Push your commits into your github fork.

    > ``` console
    > $ git push
    > (lots of useless output omitted)
    > To github.com:ubermichael/ceww.git
    > c1b3cb3..1791385  master -> master
    > ```

9.  Create a pull request. Open your fork of the project in Github and
    there should be a "Pull Request" button.

    It's a good idea to tag someone in the DHIL in the pull request by
    requesting a review.

10. Once your pull request is accepted you should update your
    repository.

    > ``` console
    > $ git pull upstream master
    > (more useless output)
    > ```

## Alternatives to the Command Line

[SourceTree](https://www.sourcetreeapp.com/) is a fine alternative to
using the command line. It will show commit history, create commits and
branches, push them to different repositories and does all sorts of
other nice things.

[GitHub Desktop](https://desktop.github.com) is also a good client, but
one that is very specific to GitHub. It offers many of the same features
as SourceTree but isn't quite as polished.

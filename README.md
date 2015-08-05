# About HyperJump
__HyperJump__ - simple and quick bookmark tool for bash and zsh shells. I found similar projects, but nothing that was both fast, easy to use, and simple enough. I really needed a location bookmarking app because I am working on a high latency connection, and switching between directories is a pain. It's also a nice memory aid. I installed it on all of the servers I manage, and now I can run something like ``jj httpd`` and jump to the right config directory for the web server on that machine, regardless of the operating system it's running. So it's basically a tool to reduce your cognitive load.

## How To Use
HyperJump consists of 3 command line commands (functions).

* __jr__ - Remember Jump. Bookmarks current directory. Run ``jr nickname`` to add current directory, or just run ``jr`` and use the interactive mode.
* __jf__ - Forget Jump. Deletes the current directory from the bookmarks. Run ``jf`` while in a directory you want forgotten or ``jf nickname`` to forget a specific nickname.
* __jj__ - Jump to a bookmark location. Run ``jj nickname`` to jump to a location or just ``jj`` to get a list of all bookmarks. You can also run ``jj nickname command`` to jump to a location and than run the command specified with "./" as the first argument. So, for instance, you can run ``jj myProject open subl`` on OSX to jump to the myProject directory and open the myProject directory in Finder and Sublime Text.

All of the commands have autocomplete. Both __jj__ and __jf__ will autocomplete with nicknames of bookmarked locations. The __jr__ command will autocomplete with the basename of the current directory. After the first argument, __jj__ will autocomplete with list of available system commands (programs).

**Examples:**

```
# Remember current directory
$ jr
$ jr MyDir

# Forget current directory
$ jf

# Forget another directory
$ jf AnotherDir

# Jump to a Directory
$ jj
$ jj MyDir
 
# Jump to a directory and open the directory in another program(s)
$ jj MyDir open
$ jj MyDir open subl tm 
```

## How To Install

Download [hyperjump](https://github.com/x0054/hyperjump/raw/master/hyperjump) bash script and place it somewhere on your system, such as ``~/bin/hyperjump``. Add the following line to your _.profile_, _.bashrc_ or _.zshrc_ file:
```
source /location/of/hyperjump
```

**Optional:** To get the list of all the Bookmarks in a nice looking menu window, you need a unix utility called _dialog_. You can install it via yum, apt-get, homebrew, ports, and others like so:

```
sudo yum install dialog
sudo apt-get install dialog
brew install dialog
sudo port install dialog
```

## Final Notes
Released under the (MIT License)[https://en.wikipedia.org/wiki/MIT_License]. Use it, love it, fork it, make changes, send pull requests. Enjoy!

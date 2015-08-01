# About HyperJump
__HyperJump__ - simple and quick bookmark tool for bash and zsh shells. I found similar projects, but nothing that was both fast, easy to use, and simple enough. I really needed a location bookmarking app because I am working on a high latency connection, and switching between directories is a pain.

## How To Use
HyperJump consists of 3 command line commands (functions).

* __jr__ - Remember Jump. Bookmarks current directory. Run "jr nickname" to add current directory, or just run "jr" and use the interactive mode.
* __jf__ - Forget Jump. Deletes the current directory from the bookmarks. Run "jf" while in a directory you want forgotten or "jf <nickname>" to forget a specific nickname.
* __jj__ - Jump to a bookmark location. Run "jj nickname" to jump to a location or just "jj" to get a list of all bookmarks.

All of the commands have autocomplete. Both __jj__ and __jf__ will autocomplete with nicknames of bookmarked locations. The __jr__ command will autocomplete with the basename of the current directory.

## How To Install

To get the list of all the Bookmarks in a nice looking menu window, you need a unix utility called _dialog_. You can install it via yum, apt-get, homebrew, ports, and others like so:

```
sudo yum install dialog
sudo apt-get install dialog
brew install dialog
sudo port install dialog
```

After just copy the _hyperjump_ script someplace on your system and add the following line to your _.profile_, _.bashrc_ or _.zshrc_ file:

```
source /location/of/hyperjump
```

## Final Notes
Use it, love it, fork it, make changes, send pull requests. Enjoy!

# Triglav's Dot Files

This is my config bundle. Its purpose is to help me not to go insane when
working on several different machines.

I am using shell script to _install_ the bundle into `$HOME` directory. I prefer
this solution over rake or any other, since not every machine I get to work on
has ruby installed.

## Download & Install

Clone the repository, run `install.sh` script and change to Z shell.

    $ git clone https://github.com/triglav/dotfiles.git ~/.dotfiles
    $ ~/.dotfiles/install.sh
    $ chsh -s `which zsh`

## Installer Features

The installer distinguishes _global_ and _local_ areas in config files.

Following line acts as a delimiter for these areas:

    DO NOT EDIT BELOW THIS LINE

This means that the content of this file below the line will be always
overwritten by the file content from repository, even if you modify it.

On the other hand, content above the line will remain unchanged. This allows you
to enter per-machine config modifications or passwords and IDs, which you would
rather not share to the public.

Credit for this cute idea goes to
[https://github.com/jferris/config_files](https://github.com/jferris/config_files).

Feel free to take, modify and use this script on your own.

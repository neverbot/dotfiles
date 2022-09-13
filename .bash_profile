# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
# umask 022

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# locales
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

export PATH=/usr/local/bin:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:$PATH

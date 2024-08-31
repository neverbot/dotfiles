# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
# umask 022

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# if we are on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

  # rbenv, choosing ruby version
  eval "$(rbenv init - bash)"

  # help with macos not finding python
  alias python=/usr/bin/python3

  # stop using clang as an alias of gcc
  alias gcc='gcc-14'
fi


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# put in history after every command (useful with multiple sessions)
PROMPT_COMMAND='history -a ; history -r'

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Comment in the above and uncomment this below for a color prompt
BLUE_BG_CYAN="\[\033[44m\]\[\033[36m\]"
GRAY="\[\033[1;30m\]"
RESET="\[\033[0m\]"
CYAN="\[\033[0;36m\]"
LIGHT_CYAN="\[\033[1;36m\]"
BRANCH="\$(parse_git_branch)"
PS1="${BLUE_BG_CYAN}\t${RESET}${CYAN} \u${GRAY}@${CYAN}\h${LIGHT_CYAN}\w${CYAN}${BRANCH}${GRAY}\$${RESET} "

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='$PROMPT_COMMAND;echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
#    ;;
#*)
#    ;;
#esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Change colors for ls console command
CLICOLOR=1
LSCOLORS=ExFxCxDxBxegedabagacad

# node version manager
NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# go lang variables
GOPATH=$HOME/go
GOROOT=/opt/homebrew/opt/go/libexec
PATH=$PATH:$GOPATH/bin
PATH=$PATH:$GOROOT/bin

# to avoid "The default interactive shell is now zsh." messages in macos:
# BASH_SILENCE_DEPRECATION_WARNING=1
# or use an updated version of bash (the one included in macos is old)
# brew update && brew install bash
# sudo chsh -s /opt/homebrew/bin/bash $(whoami)

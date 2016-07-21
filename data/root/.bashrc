# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
#export PS1='${debian_chroot:+($debian_chroot)}\[\e[01;31m\]\u\[\e[0m\]\[\e[01;37m\]@\[\e[0m\]\[\e[01;32m\]\H\[\e[0m\]\[\e[01;37m\]:\[\e[0m\]\[\e[01;35m\]\w\[\e[0m\]\[\e[00;37m\]\n\A \[\e[0m\]\[\e[01;31m\]\$\[\e[0m\] '
export PS1='${debian_chroot:+($debian_chroot)}\[\e[01;31m\]\u\[\e[0m\]\[\e[01;37m\]@\[\e[0m\]\[\e[01;32m\]$(hostname -f)\[\e[0m\]\[\e[01;37m\]:\[\e[0m\]\[\e[01;35m\]\w\[\e[0m\]\[\e[00;37m\]\n\A \[\e[0m\]\[\e[01;31m\]\$\[\e[0m\] '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# gitprompt configuration
GIT_PROMPT_ONLY_IN_REPO=1
# GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote sta
GIT_PROMPT_THEME=Custom
source /opt/bash-git-prompt/gitprompt.sh

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

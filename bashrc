# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export GOOGLE_TEST_HOME=/home/huanliz/projects/googletest/

http_proxy=http://135.251.249.250:8000
export http_proxy


alias ctags='/home/huanliz/bin/ctags'

function tags_dir()
{
        echo "`pwd`/.tags"

}
alias make_tags_dir='mkdir -p $(tags_dir)'

CTAGS=/home/huanliz/bin/ctags

alias nsn-tags='make_tags_dir; $CTAGS --sort=foldcase --recurse=yes --extra=+q --fields=+i'
alias nsn-tags-ttcn='nsn-tags --langmap=TTCN:.ttcn3 --languages=TTCN'
alias nsn-tags-cpp='nsn-tags --langmap=C++:.C.h.c.cpp.hpp --languages=C++  --c++-kinds=+p --fields=+iaS'

alias tags-cellc='    nsn-tags-cpp  -f $(tags_dir)/cpp_cellc     `pwd`/C_Application/SC_CELLC/'
alias tags-enbc='     nsn-tags-cpp  -f $(tags_dir)/cpp_enbc      `pwd`/C_Application/SC_ENBC/'
alias tags-rrom='     nsn-tags-cpp  -f $(tags_dir)/cpp_rrom      `pwd`/C_Application/SC_RROM/'
alias tags-tupc='     nsn-tags-cpp  -f $(tags_dir)/cpp_tupc      `pwd`/C_Application/SC_TUP/'
alias tags-uec='      nsn-tags-cpp  -f $(tags_dir)/cpp_uec       `pwd`/C_Application/SC_UEC/'
alias tags-mcec='     nsn-tags-cpp  -f $(tags_dir)/cpp_mcec      `pwd`/C_Application/SC_MCEC/'
alias tags-common='   nsn-tags-cpp  -f $(tags_dir)/cpp_common    `pwd`/C_Application/SC_Common/'

alias tags-lteDo='    nsn-tags-cpp  -f $(tags_dir)/cpp_lteDo     `pwd`/lteDo/'

alias tags-isar='     nsn-tags-cpp  -f $(tags_dir)/cpp_isar      `pwd`/C_Application/SC_ISAR/'
alias tags-lom='      nsn-tags-cpp  -f $(tags_dir)/cpp_lom       `pwd`/C_Application/SC_LOM/'

alias tags-interface='nsn-tags-cpp  -f $(tags_dir)/cpp_interface `pwd`/I_Interface/'

alias tags-cellc3='   nsn-tags-ttcn -f $(tags_dir)/t3_cellc      `pwd`/C_Test/cplane_k3/src/TestTargets/CELLC'
alias tags-enbc3='    nsn-tags-ttcn -f $(tags_dir)/t3_enbc       `pwd`/C_Test/cplane_k3/src/TestTargets/ENBC'
alias tags-rrom3='    nsn-tags-ttcn -f $(tags_dir)/t3_rrom       `pwd`/C_Test/cplane_k3/src/TestTargets/RROM'
alias tags-tupc3='    nsn-tags-ttcn -f $(tags_dir)/t3_tupc       `pwd`/C_Test/cplane_k3/src/TestTargets/TUPC'
alias tags-uec3='     nsn-tags-ttcn -f $(tags_dir)/t3_uec        `pwd`/C_Test/cplane_k3/src/TestTargets/UEC'
alias tags-mcec3='    nsn-tags-ttcn -f $(tags_dir)/t3_mcec       `pwd`/C_Test/cplane_k3/src/TestTargets/MCEC'
alias tags-common3='  nsn-tags-ttcn -f $(tags_dir)/t3_common     `pwd`/C_Test/cplane_k3/src/Common'

alias tags-lteDoTTCN='nsn-tags-ttcn -f $(tags_dir)/cpp_lteDoTTCN `pwd`/lteDo/'

alias tags-pit='      nsn-tags-ttcn -f $(tags_dir)/t3_pit        `pwd`/C_Test/cplane_k3/src/TestTargets/PIT'
alias tags-k3lte='    nsn-tags-ttcn -f $(tags_dir)/t3_k3lte      `pwd`/C_Test/SC_K3LTE'
alias tags-k3lteasn=' nsn-tags-ttcn -f $(tags_dir)/t3_k3lteasn   `pwd`/C_Test/SC_K3LTEASN1'

alias tags-cpp='      tags-cellc; tags-enbc; tags-rrom; tags-tupc; tags-uec; tags-mcec; tags-common; tags-lteDo; tags-isar; tags-lom; tags-interface'
alias tags-t3='       tags-cellc3; tags-enbc3; tags-rrom3; tags-tupc3; tags-uec3; tags-mcec3; tags-common3; tags-lteDoTTCN; tags-pit; tags-k3lte; tags-k3lteasn'
alias tags='          tags-cpp; tags-t3'
alias tags-rm-cpp='   rm $(tags_dir)/cpp_*'
alias tags-rm-t3='    rm $(tags_dir)/t3_*'

alias up='svn up; tags'


#function make
#{
#    if [ -f ".rmake_config" ]; then ./rmake $@ ; else $(which make) $@; fi
#}


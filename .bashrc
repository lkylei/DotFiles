#!/bin/bash
# Machine Setting {{{1

UNAME=`uname`
if [ $UNAME == "Darwin" ]; then
   export LSCOLORS="gxfxcxdxbxegedabagacad"
   alias ls='ls -G'
elif [ $UNAME == "Linux" ] || [ `uname -o` == 'Cygwin' ]; then
   alias ls='ls -F --color=auto'
   LS_COLORS='di=36:ln=94:*.h=31:*.cpp=94'
   export LS_COLORS
fi


# Host Setting {{{1

HOSTNAME=`hostname`
if [ $HOSTNAME == "PC15010220" ]; then

  cygstart .config.xlaunch
  export DISPLAY=localhost:10527
  alias mtk="ssh -Y mtk10527@mtkslt207"
  alias labpc="ssh -Y mtk10527@fe80::21a:92ff:fed2:dbfd"
  alias htopme='htop -u mtk10527'

elif [ $HOSTNAME == "mtkslt207" ]; then

  alias htopme='htop -u mtk10527'
  alias p4v="p4v &"
  export PATH=$PATH:/mtkeda/dtv/cluster/odb

  export PS1="[\u@\h \w]\\$ "
  if [ -t 0 ]; then
    clear
  fi
fi

  
# Common Setting {{{1
export TERM=xterm-256color
alias cal="echo -e '\e[1;33m'; cal -3; echo -e '\e[0m'"
if [ -d "$HOME/bin" ] ; then
   PATH="$HOME/qemu/bin:$HOME/buildroot/usr/bin:$HOME/bin:$PATH"
fi

PATH="/cygdrive/d/adb/:$HOME/qemu/bin:$HOME/buildroot/usr/bin:$HOME/bin:$PATH"
alias adbshell="stty -icanon -echo -echoe intr ^0 ; adb shell ; stty sane"
if [ -t 0 ]; then
   if tmux info &> /dev/null; then
      tmux ls
      echo ''
   fi
fi


# }}}1


# vim: foldmethod=marker foldenable
# vim: foldcolumn=2
# vim: foldlevel=0

# bashrc
#!/bin/bash
# Machine Setting

UNAME=`uname`
if [ $UNAME == "Darwin" ]; then
  export LSCOLORS="gxfxcxdxbxegedabagacad"
  alias ls='ls -G'
elif [ $UNAME == "Linux" ] || [ `uname -o` == 'Cygwin' ]; then
  alias ls='ls -F --color=auto'
  LS_COLORS='di=36:ln=94:*.h=31:*.cpp=94'
  export LS_COLORS
fi

if [ `uname -o` == 'Cygwin' ]; then
  export PS1="\[$(tput sgr0)\][\u@\h \w \[$(tput sgr0)\]\[\033[38;5;9m\]\t\[$(tput sgr0)\]]\\$ \[\033[38;5;15m\]"
  function parse_git_branch { 
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' 
  } 
  export PS1="[\[\033[38;5;243m\]\t\[$(tput sgr0)\] \u@\h: \w\$(parse_git_branch)]$ "
else  
  export PS1='[\[\e[01;31m\]\t`if [ $? = 0 ]; then echo "\[\e[32m\] ✔ "; else echo "\[\e[31m\] ✘ "; fi`\[\e[00;37m\]\u@\h\[\e[01;37m\]:`[[ $(git status 2> /dev/null) =~ Changes\ to\ be\ committed: ]] && echo "\[\e[33m\]" || echo "\[\e[31m\]"``[[ ! $(git status 2> /dev/null) =~ nothing\ to\ commit,\ working\ .+\ clean ]] || echo "\[\e[32m\]"`$(__git_ps1 "(%s)\[\e[00m\]")\[\e[01;34m\] \w\[\e[00m\]\]]$ '
  function parse_git_branch { 
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' 
  } 
  export PS1="[\[\033[38;5;243m\]\t\[$(tput sgr0)\] \u@\h: \w\$(parse_git_branch)]$ "
fi  

# Host Setting

HOSTNAME=`hostname`
if [ $HOSTNAME == "PC15010220" ]; then
  cygstart .config.xlaunch
  export DISPLAY=localhost:10527
  alias mtk="ssh -Y mtk10527@mtkslt207"
  alias labpc="ssh -Y mtk10527@fe80::21a:92ff:fed2:dbfd"
  alias htopme='htop -u mtk10527'

elif [ $HOSTNAME == "mtkslt207" ] || [ $HOSTNAME == "mtkslt212" ]; then
  export PATH=$PATH:/mtkoss/git
  export PATH=$PATH:/mtkoss/ccollab-cmdline 
  alias htopme='htop -u mtk10527'
  alias p4v="p4v &"
  export PATH=$PATH:/mtkeda/dtv/cluster/odb
  alias go-ss='cd vendor/mediatek/proprietary/external/strongswan/'

  export PS1="[\u@\h \w]\\$ "
  if [ -t 0 ]; then
    clear
  fi
  export PATH=$PATH:~/bin/p4w
  export PATH=/mtkoss/imsrepo/P4StyleChecker/bin:$PATH
  export GOROOT='/mfs/mtkslt0283/mtk10527/usr/local/go'
  export GOPATH=$GOROOT/bin
  # export GOROOT=/mtkoss/go/go1.6.linux-amd64export PATH:$PATH:$GOROOT/bin
  export PATH=$GOROOT/bin:$PATH
  export PATH=/mfs/mtkslt0283/mtk10527/usr/local/bin:$PATH
  export PATH=/mfs/mtkslt0283/mtk10527/usr/bin:$PATH
  export PATH=/proj/mtk10527/bin/usr/bin:$PATH
  export PATH=/proj/mtk10527/bin/usr/bin:$PATH
  export PATH=/proj/mtk10527/dev/clang/tools/clang-format:$PATH
  alias clang-format='clang-format -style=file'

  export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/
  export PATH="$JAVA_HOME/bin:$PATH"
  export PATH="/proj/mtk10527/.gem/ruby/2.3.0/bin:$PATH"
fi


# Common Setting 
#export TERM=xterm-256color
alias cal="echo -e '\e[1;33m'; cal -3; echo -e '\e[0m'"
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/usr/bin:$HOME/qemu/bin:$HOME/buildroot/usr/bin:$HOME/bin:$PATH"
fi

PATH="/mfs/mtkslt0204/mtk10527:/cygdrive/d/adb/:$HOME/qemu/bin:$HOME/buildroot/usr/bin:$HOME/bin:$PATH"
PATH="/mfs/mtkslt0283/mtk10527/usr/bin:$PATH"
alias adbshell="stty -icanon -echo -echoe intr ^0 ; adb shell ; stty sane"
if [ -t 0 ]; then
  if tmux info &> /dev/null; then
    tmux ls
    echo ''
  fi
fi

alias tmux='TERM=screen-256color tmux -2'
alias tmuxinator='TERM=screen-256color tmuxinator'
alias tmux='TERM=screen-256color tmux'






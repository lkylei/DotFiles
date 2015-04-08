export EDITOR=vim
export LANG=en_US.UTF-8

# alias vim='mvim'

UNAME=`uname`
if [[ $UNAME == "Darwin" ]] then
    export LSCOLORS="gxfxcxdxbxegedabagacad"
    alias ls='ls -G'
elif [[ $UNAME == "Linux" ]] || [[ `uname -o`  == 'Cygwin' ]] then
    alias ls='ls --color=auto'
    LS_COLORS='di=36:ln=94:*.h=31:*.cpp=94'
    export LS_COLORS
fi

# path alias, e.g. cd ~XXX
#hash -d WWW="/home/lighttpd/html"


# HISTORY
# number of lines kept in history
export HISTSIZE=10000
# # number of lines saved in the history after logout
export SAVEHIST=10000
# # location of history
export HISTFILE=~/.zhistory
# # append command to history file once executed
setopt INC_APPEND_HISTORY

# Disable core dumps
# limit coredumpsize 0

# vi key binding
bindkey -v
bindkey '^R' history-incremental-search-backward
# mapping del
bindkey "\e[3~" delete-char

setopt AUTO_PUSHD

WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

# auto-completion
setopt COMPLETE_ALIASES
setopt AUTO_LIST
setopt AUTO_MENU
#setopt MENU_COMPLETE
setopt MULTIBYTE

setopt correctall

autoload -U compinit
compinit

# Completion caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path .zcache
#zstyle ':completion:*:cd:*' ignore-parents parent pwd

#Completion Options
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

# Path Expansion
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*:*:*:default' menu yes select
zstyle ':completion:*:*:default' force-list always

# require /etc/DIR_COLORS to display colors in the completion list
[ -f /etc/DIR_COLORS ] && eval $(dircolors -b /etc/DIR_COLORS)
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

bindkey -M menuselect '^M' .accept-line

compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

# Group matches and Describe
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'

alias ll='ls -l'
alias grep='grep --color=auto'


function precmd {

    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))

###
# Truncate the path if it's too long.

PR_FILLBAR=""
PR_PWDLEN=""

local promptsize=${#${(%):---(-%n at %m-)-----}}
local pwdsize=${#${(%):-%~}}

if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
    ((PR_PWDLEN=$TERMWIDTH - $promptsize))
    else
        PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
        fi

###
# Get APM info.

#if which ibam > /dev/null; then
#PR_APM_RESULT=`ibam --percentbattery`
#elif which apm > /dev/null; then
#PR_APM_RESULT=`apm`
#fi
}

setopt extended_glob
preexec () {
    if [[ "$TERM" == "screen" ]]; then
        local CMD=${1[(wr)^(*=*|sudo|-*)]}
        echo -n "\ek$CMD\e\\"
        fi
}

setprompt () {
###
# Need this so the prompt will work.

    setopt prompt_subst

###
# See if we can use colors.

autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
#eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
        eval PR_$color='%{$fg[${(L)color}]%}'
        eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
        (( count = $count + 1 ))
        done
        PR_NO_COLOUR="%{$terminfo[sgr0]%}"

###
# See if we can use extended characters to look nicer.

typeset -A altchar
set -A altchar ${(s..)terminfo[acsc]}
PR_SET_CHARSET="%{$terminfo[enacs]%}"
PR_SHIFT_IN="%{$terminfo[smacs]%}"
PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
PR_HBAR=${altchar[q]:--}
PR_ULCORNER=${altchar[l]:--}
PR_LLCORNER=${altchar[m]:--}
PR_LRCORNER=${altchar[j]:--}
PR_URCORNER=${altchar[k]:--}

###
# Decide if we need to set titlebar text.

case $TERM in
xterm*)
PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
;;
screen)
PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
;;
*)
PR_TITLEBAR=''
;;
esac

###
# Decide whether to set a screen title
if [[ "$TERM" == "screen" ]]; then
    PR_STITLE=$'%{\ekzsh\e\\%}'
    else
        PR_STITLE=''
        fi

        PR_APM=''

###
# Finally, the prompt.

PROMPT='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$PR_WHITE$PR_SHIFT_IN$PR_ULCORNER$PR_HBAR$PR_SHIFT_OUT [ \
$PR_BLUE%(!.%SROOT%s.%n)$PR_WHITE at $PR_RED%m\
$PR_SHIFT_IN $PR_SHIFT_OUT$PR_MAGENTA%$PR_PWDLEN<..<%~%<< $PR_WHITE] \
$PR_SHIFT_IN$PR_HBAR${(e)PR_FILLBAR}$PR_URCORNER$PR_SHIFT_OUT\

$PR_WHITE$PR_SHIFT_IN$PR_LLCORNER$PR_HBAR$PR_SHIFT_OUT \
%(?..$PR_RED%?$PR_BLUE )\
$PR_LIGHT_BLUE%(!.$PR_RED#.$PR_WHITE\$)$PR_SHIFT_IN$PR_SHIFT_OUT\
$PR_SHIFT_IN$PR_SHIFT_OUT\
$PR_NO_COLOR '

RPROMPT=' $PR_WHITE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT \
[ $PR_YELLOW%D{%Y/%m/%d %H:%M:%S}$PR_WHITE ] $PR_SHIFT_IN$PR_HBAR$PR_LRCORNER$PR_SHIFT_OUT$PR_NO_COLOR'

PS2='$PR_LIGHT_RED%_$PR_WHITE > $PR_NO_COLOR '
}

setprompt

#alias rm="mv -t ~/.Trash"

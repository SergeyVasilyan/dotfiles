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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START UBUNTU CONFIG VARIABLES
# STOP UBUNTU CONFIG VARIABLES

readonly GIT_NEED_PULL_SYMBOL='⇣'
readonly GIT_NEED_PUSH_SYMBOL='⇡'

readonly BG_BLACK=$(tput setab 0)
readonly BG_B_RED=$(tput setab 160)
readonly BG_RED=$(tput setab 124)
readonly BG_GREEN=$(tput setab 40)
readonly BG_YELLOW=$(tput setab 3)
readonly BG_BLUE=$(tput setab 32)
readonly BG_BLUE1=$(tput setab 30)
readonly BG_BLUE2=$(tput setab 31)
readonly BG_BLUE3=$(tput setab 32)
readonly BG_BLUE4=$(tput setab 33)
readonly BG_MAGENTA=$(tput setab 135)
readonly BG_CYAN=$(tput setab 6)
readonly BG_WHITE=$(tput setab 7)
readonly BG_GREY=$(tput setab 8)

readonly FG_BLACK=$(tput setaf 0)
readonly FG_B_RED=$(tput setaf 160)
readonly FG_RED=$(tput setaf 124)
readonly FG_GREEN=$(tput setaf 40)
readonly FG_YELLOW=$(tput setaf 3)
readonly FG_BLUE=$(tput setaf 32)
readonly FG_BLUE1=$(tput setaf 30)
readonly FG_BLUE2=$(tput setaf 31)
readonly FG_BLUE3=$(tput setaf 32)
readonly FG_BLUE4=$(tput setaf 33)
readonly FG_BLUE5=$(tput setaf 252)
readonly FG_MAGENTA=$(tput setaf 135)
readonly FG_CYAN=$(tput setaf 6)
readonly FG_WHITE=$(tput setaf 7)
readonly FG_GREY=$(tput setaf 8)

readonly RESET=$(tput sgr0)
readonly BOLD=$(tput bold)
readonly DIM=$(tput dim)

export PROMPT_ALTERNATIVE="kali"
NEWLINE_BEFORE_PROMPT=no

__git_info() {
    # no .git directory
    local aheadN
    local behindN
    local branch
    local marks
    local stats
    # get current branch name or short SHA1 hash for detached head
    branch="$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always 2>/dev/null)"
    [ -n "${branch}" ] || return  # git branch not found
    # how many commits local branch is ahead/behind of remote?
    stats="$(git status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
    aheadN="$(echo "${stats}" | grep -o 'ahead [0-9]' | tr -dc '0-9')"
    behindN="$(echo "${stats}" | grep -o 'behind [0-9]' | tr -dc '0-9')"
    [ -n "${aheadN}" ] && marks+=" ${GIT_NEED_PUSH_SYMBOL}${aheadN}"
    [ -n "${behindN}" ] && marks+=" ${GIT_NEED_PULL_SYMBOL}${behindN}"
    # print the git branch segment without a trailing newline
    # branch is modified?
    if [ -n "$(git status --porcelain)" ]; then
        case "${PROMPT_ALTERNATIVE}" in
            arch)
                printf "%s" "${BG_RED}${FG_WHITE} ${branch}${marks} ${RESET}${FG_RED}";;
            kali)
                printf "%s" "${FG_RED}(${branch}${marks})${RESET}";;
        esac
    else
        case "${PROMPT_ALTERNATIVE}" in
            arch)
                printf "%s" "${BG_BLUE}${FG_WHITE} ${branch}${marks} ${RESET}${FG_BLUE}";;
            kali)
                printf "%s" "(${branch}${marks})${RESET}";;
        esac
    fi
}

PROMPT_SYMBOL=👽
PROMPT_COLOR=${FG_GREEN}
PROMPT_BG=${BG_BLUE2}
PROMPT_FG=${FG_BLUE2}

set_ps() {
    case "$1" in
        arch)
            PS1="${BG_RED}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)${RESET}${FG_RED})}"
            PS1+="${BG_BLUE1}${FG_BLUE5} \D{%Y-%m-%d %H:%M:%S} ${RESET}${FG_BLUE1}"
            PS1+="${PROMPT_BG}${FG_BLUE5} \u ${PROMPT_SYMBOL} \h ${RESET}${PROMPT_FG}"
            PS1+="\$([[ \$? == 0 ]] && echo \"${BG_BLUE3}${FG_BLUE5} \342\234\223 ${RESET}${FG_BLUE3}\""
            PS1+=" || echo \"${BG_RED}${FG_WHITE} \342\234\227 ${RESET}${FG_RED}\")"
            PS1+="${BG_BLUE4}${FG_BLUE5} \w "
            PS1+="[\$(ls -1 | wc -l | sed 's: ::g') files, "
            PS1+="\$(ls -sh | head -n1 | sed 's/total //')] ${RESET}${FG_BLUE4}\n"
            PS1+="${FG_CYAN}\$(__git_info)${RESET} ";;
        kali)
            PS1="${PROMPT_COLOR}┌─${VIRTUAL_ENV:+(${reset}$(basename $VIRTUAL_ENV)${PROMPT_COLOR})}─"
            PS1+="[${FG_MAGENTA}\D{%Y-%m-%d %H:%M:%S}${PROMPT_COLOR}]─"
            PS1+="{${PROMPT_FG}\u ${PROMPT_SYMBOL} \h${PROMPT_COLOR}}─"
            PS1+="(${FG_YELLOW}\$? \$([[ \$? == 0 ]] && echo \"${FG_GREEN}\342\234\223\" "
            PS1+="|| echo \"${FG_RED}\342\234\227\")${PROMPT_COLOR})─"
            PS1+="(${FG_B_RED}\w "
            PS1+="${FG_YELLOW}\$(ls -1 | wc -l | sed 's: ::g')${FG_GREEN} files${PROMPT_COLOR}, "
            PS1+="${FG_YELLOW}\$(ls -sh | head -n1 | sed 's/total //')${PROMPT_COLOR})\n"
            PS1+="└─${FG_CYAN}\$(__git_info)${PROMPT_COLOR}─"
            PS1+="${PROMPT_FG}\$${RESET} ";;
        ubuntu)
            PS1="${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}${debian_chroot:+($debian_chroot)}${PROMPT_FG}\u@\h${RESET}:${PROMPT_COLOR}\[\033[01m\]\w${RESET}\$ ";;
    esac
    PROMPT_ALTERNATIVE="$1"
}

if [ "$color_prompt" = yes ]; then
    VIRTUAL_ENV_DISABLE_PROMPT=1
    if [ "$EUID" -eq 0 ]; then # Change prompt colors for root user
        PROMPT_SYMBOL=☠️
        PROMPT_COLOR=${FG_BLUE}
        PROMPT_BG=${BG_B_RED}
        PROMPT_FG=${FG_B_RED}
    fi
    set_ps ${PROMPT_ALTERNATIVE}
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

[ "$NEWLINE_BEFORE_PROMPT" = yes ] && PROMPT_COMMAND="PROMPT_COMMAND=echo"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
export GIT_SSL_NO_VERIFY=1
export EDITOR="vim"
source ~/.local/share/blesh/ble.sh

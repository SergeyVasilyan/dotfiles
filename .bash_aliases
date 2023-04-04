alias py="python3"
alias vims="vim"
alias vi="vim"
alias ws="cd ~/workspace"
#--------------------------------------GIT-----------------------------------------#
alias gstatus="git status"
alias gpush="git push"
git() {
    if [ "$1" = "log" ]; then
        command git log --graph --stat --pretty=format:"%C(yellow)Commit: %H%Creset %C(cyan)%d%Creset%n%CredAuthor%Creset: %Cblue%an <%ae>%Creset%n%CredDate%Creset:   %Cgreen%ad%Creset%n%CredMessage%Creset:%n%n%B""${@:2}"
    else
        command git "$@"
    fi;
}
#----------------------------------------------------------------------------------#
alias upgrade="sudo nala upgrade"
alias i3-config="vim ~/.config/i3/config"
alias i3-blocks="vim ~/.config/i3/i3blocks.conf"
alias i3-scripts="vim ~/.config/i3/bin/"
alias sway-config="vim ~/.config/sway/config"
alias sway-blocks="vim ~/.config/sway/i3blocks.conf"
alias sway-scripts="vim ~/.config/sway/bin/"
alias waybar-config="vim ~/.config/waybar/config"
eval $(thefuck --alias helpme)

if [ -f "/opt/coreutils/bin/ls" ]; then
    ls() {
        command /opt/coreutils/bin/ls --color=auto "$@"
    }
fi

if [ -f "/bin/batcat" ]; then
    cat() {
        command batcat --color=auto "$@"
    }
fi
alias tetris=/snap/bin/tetris-thefenriswolf.tetris

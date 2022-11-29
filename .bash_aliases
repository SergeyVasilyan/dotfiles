alias py="python3"
alias vims="vim"
alias vi="vim"
alias cdk="cd ~/workspace/kampr-face-access-control/"
alias fdk="cd ~/workspace/kampr-testing/"
alias ldk="cd ~/workspace/security_systems/"
alias lab="ssh -X upsquared@172.17.15.23"
alias vm="ssh -X 172.17.15.19"
alias b1="ssh -X upsquared@172.17.1.65"
#--------------------------------------GIT-----------------------------------------#
alias gstatus="git status"
alias gpush="git push"
git() {
    if [ "$1" = "log" ]; then
        command git log --graph --stat --pretty=format:"%C(yellow)Commit: %H%Creset %C(cyan)%d%Creset%n%CredAuthor%Creset: %Cblue%an <%ae>%Creset%n%CredDate%Creset:   %Cgreen%ad%Creset%n%CredMessage%Creset:%n%n%B""${@:2}";
    else
        command git "$@";
    fi;
}
#----------------------------------------------------------------------------------#
alias update="sudo apt update"
alias upgrade="sudo apt upgrade"
eval $(thefuck --alias helpme)
alias i3-config="vim ~/.config/i3/config"
alias i3-blocks="vim ~/.config/i3/i3blocks.conf"

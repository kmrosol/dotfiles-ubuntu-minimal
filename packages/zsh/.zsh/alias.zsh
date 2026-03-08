#-------------------------------------------
# Utils
#-------------------------------------------

alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"
alias cd='(){cd $1 && ls}'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdirr='(){mkdir $1 && cd $1}'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias -g C="| pbcopy "
alias python="python3"
alias pip="pip3"
alias rzsh="source ~/.zshrc"
alias cpwd="pwd | pbcopy"

alias awk="gawk"

alias clear="clear && tmux clear-history || clear"
# alias clear='[[ -z "$TMUX" ]] && tmuxclear || clear'
# alias clear="tmux clear-history || clear"

#-------------------------------------------
# Replace vim with nvim
#-------------------------------------------

alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias v="nvim ."


#-------------------------------------------
# Open specific dir with vim
#-------------------------------------------

alias dotconfig="vim ~/dotfiles"
alias vimconfig="vim ~/.config/nvim"
alias zshconfig="vim ~/.zsh"


#-------------------------------------------
# Git
#-------------------------------------------

alias g="git"
alias gs="git status"
alias gc="git commit"
alias ga="git add"
alias gco="git checkout"
alias gb="git branch"
alias gba="git branch -a"
alias gd="git diff"
alias gst="git stash"
alias gf="git fetch"
alias gm-"git merge"
alias gr="git remote"
alias gp="git push"
alias gsw="git switch"

#-------------------------------------------
# Docker
#-------------------------------------------

alias d="docker"
alias dc="docker compose"

#-------------------------------------------
# Move to a specific directory
#-------------------------------------------

alias dotfiles="cd ~/dotfiles"

#-------------------------------------------
# Executiton
#-------------------------------------------
alias dotinstall="source ~/dotfiles/bootstrap.sh"

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/personal/scripts:$PATH"
export EDITOR="nvim"

export MANPAGER="nvim +Man!"

ZSH_THEME="robbyrussell"


plugins=(git zsh-autosuggestions)
alias vim="nvim"
alias tms="~/personal/scripts/tmux-sessionizer"
alias clip="wl-copy"
alias upd="sudo pacman -Syu --noconfirm ; yay -Syyu ; flatpak update -y"
alias glo="git log --oneline"
alias sla="git shortlog -s -n --all --no-merges"
alias oops="git reset --soft HEAD~1"
## remove orphans packages
rop() {
    orphans=$(pacman -Qdtq)
    if [[ -n "$orphans" ]]; then
        echo "Orphaned packages detected:"
        echo "$orphans"
        
        sudo pacman -Rns $(echo "$orphans")
    else
        echo "No orphan packages to remove!"
    fi
}
##

## find file
fdd() {
  file=$(fzf --preview "bat {}")
  if [[ -n "$file" ]]; then
    vim "$file"
  fi
}
##

source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)
# eval "$(oh-my-posh init zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.toml)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

. "$HOME/.local/share/../bin/env"

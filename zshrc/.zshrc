export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/scripts:$PATH"
export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"
export EDITOR="nvim"

export MANPAGER="nvim +Man!"

ZSH_THEME="robbyrussell"


plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)
# eval "$(oh-my-posh init zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.toml)"

source ~/.zsh_alias
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

. "$HOME/.local/share/../bin/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/kranku/.lmstudio/bin"
# End of LM Studio CLI section


export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000
setopt SHARE_HISTORY
export PATH=$PATH:$HOME/.cargo/bin
export EDITOR=nvim
export PAGER=bat
alias n=nvim
alias ls="exa --icons"
alias gzip=pigz
alias gunzip=unpigz
alias lg=lazygit

currentTime=`date +"%H"`
if [[ $currentTime -ge "08" && $currentTime -le "16" ]] 
then
  export GTK_THEME=Adwaita:light 
else
  export GTK_THEME=Adwaita:dark 
fi

export GTK_THEME=Adwaita:dark 

eval "$(starship init zsh)"

bindkey -v
bindkey '^R' history-incremental-search-backward

# Lukas and Grant's Magic Sauce
function wo {
    cd "$(cat <<(fd --base-directory=$HOME --type d -c never | awk '{print "~/"$0}' | sort) <<(echo "~") | fzf $([ -z "$1" ] || echo "-q$1") --tac | sed "s#~#$HOME#g")"
}

# Use CTRL-Z instead of `fg`
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

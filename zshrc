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
if [[ $currentTime -ge "08" && $currentTime -le "20" ]] 
then
  export GTK_THEME=Adwaita:light 
else
  export GTK_THEME=Adwaita:dark 
fi

  export GTK_THEME=Adwaita:dark 

eval "$(starship init zsh)"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey -v
bindkey '^R' history-incremental-search-backward

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

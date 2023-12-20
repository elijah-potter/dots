export EDITOR=nvim
export PAGER=bat
alias n=nvim
alias ls="exa --icons"
alias gzip=pigz
alias gunzip=unpigz
alias lg=lazygit

currentTime=`date +"%H"`
if [[ $currentTime -ge "08" && $currentTime -le "20"  ]] 
then
  export GTK_THEME=Adwaita:light 
else
  export GTK_THEME=Adwaita:dark 
fi

eval "$(starship init zsh)"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey -v
bindkey '^R' history-incremental-search-backward

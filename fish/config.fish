set -U fish_greeting
set -x PATH $PATH:$HOME/.cargo/bin
set -x PATH $PATH:$HOME/go/bin
set -x EDITOR nvim
set -x PAGER bat

if status is-interactive
  set -x GTK_THEME Adwaita:dark

  # Use CTRL-Z to go back to background task
  bind \cz 'fg 2>/dev/null; commandline -f repaint'

  alias n=nvim
  alias ls="exa --icons"
  alias gzip=pigz
  alias gunzip=unpigz
  alias lg=lazygit
  
  fish_user_key_bindings

  starship init fish | source
end


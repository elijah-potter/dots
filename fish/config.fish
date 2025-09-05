set -U fish_greeting
if not contains cargo $PATH
  fish_add_path $HOME/.cargo/bin
  fish_add_path $HOME/go/bin
  fish_add_path $HOME/.dotnet/tools
  fish_add_path $HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer
  set -x EDITOR nvim
  set -x PAGER bat
  set -x SCCACHE_CACHE_SIZE 25G
end

if status is-interactive
  set HOUR (date '+%H')

  if test "7" -le $HOUR && test $HOUR -lt "21"
    set -x GTK_THEME Adwaita:light
    set -x BAT_THEME GitHub
    modus_operandi
  else
    set -x GTK_THEME Adwaita:dark
    modus_vivendi
  end

  # Use CTRL-Z to go back to background task
  bind \cz 'fg 2>/dev/null; commandline -f repaint'

  alias n=nvim
  alias ls="eza --icons"
  alias gzip=pigz
  alias gunzip=unpigz
  alias lg=lazygit
  alias cdo="cargo doc --open"
  
  fish_user_key_bindings

  starship init fish | source
end


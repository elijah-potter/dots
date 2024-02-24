function fish_user_key_bindings
  fish_default_key_bindings -M insert
  fish_vi_key_bindings --no-erase insert

  bind -M insert \cz 'fg 2>/dev/null; commandline -f repaint'
end

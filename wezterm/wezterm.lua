local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Can enable dark mode changing it to "Violet Dark"
config.color_scheme = "Violet Light"
config.font = wezterm.font('JetBrains Mono', {})
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 0,
  right = 0,
  bottom = 0,
  top = 0
}

return config

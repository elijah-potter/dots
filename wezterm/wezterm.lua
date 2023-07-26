local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local dark_theme = "carbonfox"
local light_theme = "dayfox"

-- Set the color scheme based on the system theme
if os.getenv("GTK_THEME"):find "dark" then
  config.color_scheme = dark_theme
else
  config.color_scheme = light_theme
end

config.use_fancy_tab_bar = false
config.font = wezterm.font('Victor Mono', {})
config.font_size = 12
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 0,
  right = 0,
  bottom = 0,
  top = 0
}

config.leader = { key = 'a', mods = 'CTRL', timout_milliseconds = 1000 }

config.keys = {
  {
    key = '\\',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'x',
    mods = "LEADER",
    action = wezterm.action.CloseCurrentPane { confirm = true }
  },
  {
    key = 'c',
    mods = "LEADER",
    action = wezterm.action.SpawnTab "DefaultDomain"
  },
  {
    key = 'b',
    mods = "LEADER",
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    key = 'n',
    mods = "LEADER",
    action = wezterm.action.ActivateTabRelative(1)
  },
  {
    key = 'z',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    key = '+',
    mods = 'CTRL',
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = '_',
    mods = 'CTRL',
    action = wezterm.action.DecreaseFontSize,
  },
  {
		key="p",
    mods="LEADER",
    action = wezterm.action_callback(function(window, pane)
      local overrides = window:get_config_overrides() or {}
      if (overrides.color_scheme == light_theme)
      then
        overrides.color_scheme = dark_theme
      else
        overrides.color_scheme = light_theme
      end
      window:set_config_overrides(overrides)
    end),
  }
}

return config

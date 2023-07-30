-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"

config.default_domain = 'WSL:Ubuntu-22.04'
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- config.enable_scroll_bar = true
config.scrollback_lines = 30000

config.keys = {
  {
    key = '\\',
    mods = 'CTRL',
    action = wezterm.action.SplitHorizontal,
  },
  {
    key = '/',
    mods = 'CTRL',
    action = wezterm.action.SplitVertical,
  },
}

-- and finally, return the configuration to wezterm
return config

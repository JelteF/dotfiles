-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font 'UbuntuMono'
config.font_size = 10.7
-- config.font = wezterm.font 'JetBrains Mono'
-- config.font_size = 9.0
-- disable ligatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.color_scheme = "Catppuccin Mocha"

-- config.default_domain = 'WSL:Ubuntu-22.04'
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- config.enable_scroll_bar = true
config.scrollback_lines = 30000

config.pane_focus_follows_mouse = true

local act = wezterm.action

config.keys = {
  {
    key = '\\',
    mods = 'CTRL',
    action = act.SplitHorizontal,
  },
  {
    key = '/',
    mods = 'CTRL',
    action = act.SplitVertical,
  },
  {
    key = 'LeftArrow',
    mods = 'ALT|SHIFT',
    action = act.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'RightArrow',
    mods = 'ALT|SHIFT',
    action = act.AdjustPaneSize { 'Right', 5 },
  },
  {
    key = 'UpArrow',
    mods = 'ALT|SHIFT',
    action = act.AdjustPaneSize { 'Up', 3 },
  },
  {
    key = 'DownArrow',
    mods = 'ALT|SHIFT',
    action = act.AdjustPaneSize { 'Down', 3 },
  }
}

-- and finally, return the configuration to wezterm
return config

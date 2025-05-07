local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = "BlulocoDark"
config.window_decorations = "TITLE|MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR"
config.hide_tab_bar_if_only_one_tab = false

return config

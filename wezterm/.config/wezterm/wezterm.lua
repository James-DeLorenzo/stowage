local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

local function pane_or_tab(direction, tab_offset)
    return wezterm.action_callback(function(window, pane)
        local tab = pane:tab()
        if not tab then
            return
        end

        local adjacent = tab:get_pane_direction(direction)
        if adjacent then
            window:perform_action(act.ActivatePaneDirection(direction), pane)
        else
            window:perform_action(act.ActivateTabRelative(tab_offset), pane)
        end
    end)
end

config.color_scheme = "BlulocoDark"
config.colors = {
    split = "#4b6378",
}
config.font = wezterm.font {
    family = "JetBrainsMono NFM",
    weight = "Regular",
    harfbuzz_features = {
        "cv03",
        "cv06",
        "cv07",
        "cv10",
        "cv14",
        "cv15",
        "ss20",
        "zero"
    }
}
config.font_size = 13
config.window_decorations = "TITLE|MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR"
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.72,
}
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false
config.leader = { key = "Space", mods = "ALT", timeout_milliseconds = 1000 }
config.keys = {
    { key = "m", mods = "LEADER", action = act.ActivateKeyTable { name = "move_mode", one_shot = false } },
    { key = "s", mods = "LEADER", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "v", mods = "LEADER", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "w", mods = "LEADER", action = act.CloseCurrentPane { confirm = true } },
}
config.key_tables = {
    move_mode = {
        { key = "h",      action = pane_or_tab("Left", -1) },
        { key = "j",      action = act.ActivatePaneDirection("Down") },
        { key = "k",      action = act.ActivatePaneDirection("Up") },
        { key = "l",      action = pane_or_tab("Right", 1) },
        { key = "H",      action = act.AdjustPaneSize { "Left", 3 } },
        { key = "J",      action = act.AdjustPaneSize { "Down", 3 } },
        { key = "K",      action = act.AdjustPaneSize { "Up", 3 } },
        { key = "L",      action = act.AdjustPaneSize { "Right", 3 } },
        { key = "s",      action = act.SplitVertical { domain = "CurrentPaneDomain" } },
        { key = "v",      action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
        { key = "w",      action = act.CloseCurrentPane { confirm = true } },
        { key = "i",      action = "PopKeyTable" },
        { key = "Escape", action = "PopKeyTable" },
        { key = "q",      action = "PopKeyTable" },
    },
}

return config

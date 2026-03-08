local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Hide tabs
config.hide_tab_bar_if_only_one_tab = true

-- Fonts
config.line_height = 1.2
config.font = wezterm.font('Ubuntu Mono')
config.font_size = 20.0

-- toggle transparency on 'toggle-opacity' event
wezterm.on('toggle-opacity', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  overrides.window_background_opacity =  overrides.window_background_opacity == nil and 0.8 or nil
  window:set_config_overrides(overrides)
end)

-- Toggle transparency with cmd+shift+b
keys = {
  {
    key = 'B',
    mods = 'CMD',
    action = wezterm.action.EmitEvent 'toggle-opacity',
  },
}

config.keys = keys

return config

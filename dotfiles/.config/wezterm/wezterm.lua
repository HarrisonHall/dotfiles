-- Wezterm configuration

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Launch
-- config.default_prog = { 'tmux', 'new-session', '-A', '-s', 'MAIN' }
config.default_prog = { 'zellij', 'attach', '-c', 'Main' }
-- config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Themeing
config.term = "xterm-256color"
config.font = wezterm.font_with_fallback {
  'HackGen35 Console NF',
  'M PLUS 1 Code',
  'Font Awesome 6 Free',
  'Font Awesome 6 Brands',
}
config.font_size = 12.0
config.color_scheme = "Catppuccin Macchiato"
config.window_padding = {
  left = '0.5cell',
  right = '0.5cell',
  top = '0.25cell',
  bottom = '0.25cell',
}

-- Keybinds
config.keys = {
  -- Disable accidental zoom-in
  {
    key = '=',
    mods = 'CTRL',
    action = wezterm.action.DisableDefaultAssignment,
  },
  -- Disable accidental zoom-out
  {
    key = '-',
    mods = 'CTRL',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

-- Temp bug fix
config.front_end = 'WebGpu'

-- CENTER

function set_default (t, d)
  local mt = {__index = function () return d end}
  setmetatable(t, mt)
end

-- Choose padding based on window size
function compute_padding(window, cfg_padding)
  -- Get window size and corresponding padding
  local w = cfg_padding.w[window:get_dimensions().pixel_width]
  local h = cfg_padding.h[window:get_dimensions().pixel_height]

  -- Set padding
  local overrides = window:get_config_overrides() or {}
  overrides.window_padding = {
    left = w.left,
    right = w.right,
    top = h.top,
    bottom = h.bottom,
  }
  window:set_config_overrides(overrides)
end

-- [[ Config Start ]]

local padding_table = { w = {}, h = {} }
-- Fullscreen
padding_table.w[1920] = { left = 0, right = 0 }
padding_table.h[1080] = { top = 4, bottom = 5 }

-- Full
padding_table.w[1914] = { left = 2, right = 2 }
padding_table.h[1074] = { top = 1, bottom = 2 }

-- Half
padding_table.w[954] = { left = 2, right = 2 }
padding_table.h[534] = { top = 4, bottom = 5 }

set_default(padding_table.w, { left = 0, right = 0 })
set_default(padding_table.h, { top = 0, bottom = 0 })

-- [[ Config End ]]

wezterm.on("window-resized", function(window)
  util.compute_padding(window, padding_table)
end);

wezterm.on("window-config-reloaded", function(window)
  util.compute_padding(window, padding_table)
end);

-- CENTER


-- and finally, return the configuration to wezterm
return config

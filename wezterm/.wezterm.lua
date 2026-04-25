local wezterm = require("wezterm")
local launch_menu = {}

local config = wezterm.config_builder()

config.hyperlink_rules = wezterm.default_hyperlink_rules()

config.initial_cols = 128
config.initial_rows = 28
config.font_size = 13
config.font = wezterm.font("Intel One Mono")
config.color_scheme = 'GruvboxDarkHard'

config.keys = {
  { key = 'LeftArrow',  mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
}

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.5,
}

local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_macos = wezterm.target_triple:find("apple") ~= nil

if is_windows then
  config.enable_kitty_keyboard = false
  config.font = wezterm.font_with_fallback{"IntoneMono Nerd Font", "Intel One Mono"}
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'pwsh.exe', '-NoLogo' },
  })
  table.insert(launch_menu, {
    label = 'PowerShell (Old)',
    args = { 'powershell.exe', '-NoLogo' },
  })
  config.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe", "--login", "-i" }
end

if is_macos then
  config.window_background_opacity = 0.75
  config.send_composed_key_when_left_alt_is_pressed = false
  config.send_composed_key_when_right_alt_is_pressed = false
  config.quit_when_all_windows_are_closed = true

  config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

  config.font = wezterm.font_with_fallback({
    "Intel One Mono",
    "SF Mono",
  })
end

config.launch_menu = launch_menu

return config

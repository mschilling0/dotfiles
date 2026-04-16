local wezterm = require("wezterm")
local launch_menu = {}

local config = wezterm.config_builder()

config.hyperlink_rules = wezterm.default_hyperlink_rules()

config.initial_cols = 128
config.initial_rows = 28
config.font_size = 13
config.font = wezterm.font_with_fallback{"IntoneMono Nerd Font", "Intel One Mono"}
config.color_scheme = 'GruvboxDarkHard'

local is_windows = wezterm.target_triple:find("windows") ~= nil

if is_windows then
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' },
  })
  config.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe", "--login", "-i" }
end
config.launch_menu = launch_menu

return config

local wezterm = require("wezterm")
local launch_menu = {}

local config = wezterm.config_builder()

config.hyperlink_rules = wezterm.default_hyperlink_rules()

config.initial_cols = 128
config.initial_rows = 28
config.font_size = 13
config.scrollback_lines = 10000
config.font = wezterm.font("Intel One Mono")
config.color_scheme = 'GruvboxDarkHard'

config.keys = {
  { key = 'LeftArrow',  mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'd', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 's', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
  { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard' },
}

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.5,
}

local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_macos = wezterm.target_triple:find("apple") ~= nil

if is_windows then
  config.enable_kitty_keyboard = true
  config.font = wezterm.font_with_fallback{"IntoneMono Nerd Font", "Intel One Mono", "Cascadia Code"}

  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'pwsh.exe', '-NoLogo' },
  })

  table.insert(launch_menu, {
    label = 'PowerShell (Old)',
    args = { 'powershell.exe', '-NoLogo' },
  })

  table.insert(launch_menu, {
    label = 'Git Bash',
    args = { 'C:\\Program Files\\Git\\bin\\bash.exe', '--login', '-i' },
  })

  -- Find installed visual studio version(s) and add their compilation
  -- environment command prompts to the menu
  for _, vcvars in
    ipairs(
      wezterm.glob(
        'Microsoft Visual Studio/20*/*/VC/Auxiliary/Build/vcvars64.bat',
        'C:/Program Files'
      )
    )
  do
    local year, edition =
      vcvars:match('Microsoft Visual Studio[/\\](20%d%d)[/\\]([^/\\]+)')
    table.insert(launch_menu, {
      label = 'CMD x64 Native Tools VS ' .. year .. ' ' .. edition,
      args = { 'cmd.exe', '/k', 'C:/Program Files/' .. vcvars },
    })
  end

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

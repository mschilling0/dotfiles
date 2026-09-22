-- nvim/.config/nvim/lua/plugins/ui.lua

vim.cmd("colorscheme gruvbox")

require("lualine").setup()

vim.ui.select = function(...)
  require("fzf-lua").register_ui_select()
  return vim.ui.select(...)
end

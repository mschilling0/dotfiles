-- nvim/.config/nvim/lua/plugins/ui.lua

vim.cmd("colorscheme gruvbox")

require("lualine").setup()

require("fzf-lua").register_ui_select()

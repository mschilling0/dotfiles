-- nvim/.config/nvim/lua/plugins/ui.lua

vim.cmd("colorscheme gruvbox")

require("lualine").setup()

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

require("fzf-lua").register_ui_select()

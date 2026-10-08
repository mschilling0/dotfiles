-- nvim/.config/nvim/lua/plugins/ui.lua

vim.cmd("colorscheme gruvbox")

require("lualine").setup()

vim.ui.select = function(...)
  require("fzf-lua").register_ui_select()
  return vim.ui.select(...)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  once = true,
  callback = function()
    require('render-markdown').setup({
      completions = { lsp = { enabled = true } }
    })
  end,
})


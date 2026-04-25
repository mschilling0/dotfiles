-- nvim/.config/nvim/lua/options.lua

-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Disabling netrw (built-in file explorer) to favor nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.history = 500
vim.opt.timeoutlen = 500

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.smarttab = true
vim.opt.wrap = true
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.wildmenu = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.fileformats = "unix,mac,dos"
vim.opt.wildmode = "longest:full,full"
vim.opt.backspace = "eol,start,indent"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250

vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"

vim.opt.showmatch = true
vim.opt.textwidth = 79
vim.opt.termguicolors = true

vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.splitright = true
vim.opt.splitbelow = true

-- Toggle ignorecase based on command type
-- This makes search (/, ?) case-insensitive but find/replace (:) case-sensitive
vim.api.nvim_create_autocmd("CmdlineEnter", {
  group = vim.api.nvim_create_augroup("CaseManagement", { clear = true }),
  callback = function()
    local type = vim.fn.getcmdtype()
    if type == ":" then
      vim.opt.ignorecase = false
    elseif type == "/" or type == "?" then
      vim.opt.ignorecase = true
    end
  end,
})

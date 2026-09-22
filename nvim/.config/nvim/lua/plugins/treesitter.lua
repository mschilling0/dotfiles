-- nvim/.config/nvim/lua/plugins/treesitter.lua

local ts = require("nvim-treesitter")

local ensure = {
  "c",
  "cpp",
  "lua",
  "python",
  "javascript",
  "html",
  "css",
  "bash",
  "rust",
  "go",
  "json",
  "cmake",
  "markdown",
  "yaml",
  "toml",
  "editorconfig",
  "doxygen",
  "fortran",
  "gitignore",
  "make",
  "ninja",
  "proto",
  "latex",
}

local installed = ts.get_installed("parsers")
local missing = vim.tbl_filter(function(lang)
  return not vim.list_contains(installed, lang)
end, ensure)

if #missing > 0 then
  vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
      vim.notify(("nvim-treesitter: installing %d parser(s)…"):format(#missing))
      ts.install(missing) -- async; do not :wait() here
    end,
  })
end

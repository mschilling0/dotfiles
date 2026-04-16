-- nvim/.config/nvim/lua/plugins/treesitter.lua

require("nvim-treesitter").setup({
  ensure_installed = {
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
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
})

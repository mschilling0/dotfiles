-- begin For NVIM TREE
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- end For NVIM TREE

vim.cmd("filetype plugin on")
vim.opt.langmenu = "en_US.UTF-8"
vim.opt.encoding = "utf-8"

vim.opt.number = true
vim.opt.history = 500
vim.opt.tm = 500

vim.opt.ruler = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.wrap = true
vim.opt.ffs = "unix,mac,dos"
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.backspace = "eol,start,indent"

vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ttyfast = true
vim.opt.lazyredraw = true
vim.opt.updatetime = 300

vim.opt.magic = true
vim.opt.showmatch = true

vim.opt.textwidth = 79
vim.opt.termguicolors = true

-- begin for LSP
-- FROM: https://lsp-zero.netlify.app/v3.x/blog/you-might-not-need-lsp-zero.html
--
-- note: diagnostics are not exclusive to lsp servers
-- so these can be global keybindings
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup({})

require('mason-lspconfig').setup({
  automatic_enable = true
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    -- Enter key confirms completion item
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl + space triggers completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

vim.lsp.enable('clangd')
vim.lsp.config('clangd', {
  cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--fallback-style=Google",
          "--completion-style=bundled",
          "--cross-file-rename",
  },
})

vim.lsp.enable('pyright')

require("gruvbox").load()
require("lualine").setup()

-- begin For NVIM TREE
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
-- end For NVIM TREE

require('fzf-lua').register_ui_select()
require("plenary")

require("nvim-treesitter").setup {
  ensure_installed = { "c", "cpp", "lua", "python", "javascript", "html", "css", "bash", "rust", "go", "json", "cmake", "markdown", "yaml", "toml", "editorconfig", "doxygen", "fortran", "gitignore", "make", "ninja", "proto", "latex" },   highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}

-- Copilot inline suggestions + auth setup
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    require("copilot").setup({
      suggestion = { auto_trigger = true }
    })
  end,
  once = true,
})

-- Copilot Chat mode
require("CopilotChat").setup({
  model = "gemini-3-pro-preview",
})

-- Using Claude/Gemini/w/e CLI within neovim
require("sidekick").setup({
   nes = { enabled = false },
})
